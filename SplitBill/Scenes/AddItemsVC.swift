//
//  AddItemsVC.swift
//  SplitBill
//
//  Created by Clive Liu on 11/23/20.
//

import UIKit
import Vision
import VisionKit

class AddItemsVC: SBTableViewController {
    
    private let addItemsButton = SBButton(icon: SFSymbols.add)
    private let priceTagPattern = "^\\$?-?\\d+\\.\\d{2}-?"
    private let pricePattern = "\\d+\\.\\d{2}"
    
    private var people = [Person]()
    private var textRecognitionRequest = VNRecognizeTextRequest()
    
    private var items = [Item]()
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .large)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextRecognitionRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPeople()
    }
    
    override func layoutUI() {
        super.layoutUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.action, style: .plain, target: self, action: #selector(actionButtonTapped))
        
        configureAddItemsButton()
        configureActivityIndicator()
    }
    
    override func configureTableView() {
        super.configureTableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AddItemCell.self, forCellReuseIdentifier: AddItemCell.identifier)
    }

}


extension AddItemsVC {

    private func configureAddItemsButton() {
        view.addSubview(addItemsButton)
        
        addItemsButton.addTarget(self, action: #selector(addItemsButtonTapped), for: .touchUpInside)
        
        let padding:CGFloat = 30
        let size: CGFloat = 50
        
        NSLayoutConstraint.activate([
            addItemsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            addItemsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            addItemsButton.widthAnchor.constraint(equalToConstant: size),
            addItemsButton.heightAnchor.constraint(equalToConstant: size)
        ])
    }
    
    private func configureActivityIndicator() {
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func loadPeople() {
        do {
            people = try PersistenceManager.shared.context.fetch(Person.fetchRequest())
        } catch {
            print("Failed to load people")
        }
    }
    
    @objc
    private func actionButtonTapped() {
        guard !activityIndicator.isAnimating else { return }
        
        let alert = UIAlertController(title: "Choose an action", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Assign", style: .default, handler: { [weak self] (_) in
            self?.assign()
        }))
        
        alert.addAction(UIAlertAction(title: "Edit Tax", style: .default, handler: { [weak self] (_) in
            self?.editTax()
        }))
        
        alert.addAction(UIAlertAction(title: "Delete All", style: .destructive, handler: { [weak self] (_) in
            self?.clear()
        }))
        
        alert.addAction(UIAlertAction(title: "Select All", style: .default, handler: { [weak self] (_) in
            self?.select(all: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Deselect All", style: .default, handler: { [weak self] (_) in
            self?.select(all: false)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        present(alert, animated: true)
    }
    
    @objc
    private func addItemsButtonTapped() {
        guard !activityIndicator.isAnimating else { return }
        
        let alert = UIAlertController(title: "Add items", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Manual", style: .default, handler: { [weak self] (_) in
            self?.addItem()
        }))
        
        alert.addAction(UIAlertAction(title: "Scan", style: .default, handler: { [weak self] (_) in
            self?.scanReceipt()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        present(alert, animated: true)
    }
    
    private func assign() {
        let selected = items.filter({$0.itemSelected})
        guard !selected.isEmpty else { return }
        
        let alert = UIAlertController(title: "Assign to", message: nil, preferredStyle: .actionSheet)
        
        for person in people {
            alert.addAction(UIAlertAction(title: person.name, style: .default, handler: { (_) in
                for item in selected {
                    person.items.insert(item)
                }
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        present(alert, animated: true)
    }
    
    private func select(all state: Bool) {
        for item in items {
            item.itemSelected = state
        }
        tableView.reloadData()
    }
    
    private func editTax() {
        let selected = items.filter({$0.itemSelected})
        guard !selected.isEmpty else { return }
        
        let alert = UIAlertController(title: "Change Tax", message: "change every selected items' tax to", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Tax % (Optional: default 0 %)"
            textField.keyboardType = .decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            guard let self = self,
                  let taxString = alert.textFields?.first?.text
            else { return }
            
            for item in selected {
                item.tax = Float(taxString) ?? 0
            }
            self.tableView.reloadData()
        }))
        
        present(alert, animated: true)
    }
    
    private func clear() {
        items.removeAll()
        tableView.reloadData()
    }

    private func addItem() {
        let alert = UIAlertController(title: "Add item", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Item name"
            textField.keyboardType = .alphabet
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Item value"
            textField.keyboardType = .decimalPad
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Tax % (Optional: default 0 %)"
            textField.keyboardType = .decimalPad
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (_) in
            guard let self = self,
                  let name = alert.textFields?[0].text,
                  !name.isEmpty,
                  let valueText = alert.textFields?[1].text,
                  !valueText.isEmpty,
                  let value = Float(valueText),
                  let taxTax = alert.textFields?[2].text
            else { return }
            
            let item = Item(context: PersistenceManager.shared.context)
            item.name = name
            item.value = value
            item.tax = Float(taxTax) ?? 0
            
            self.items.append(item)
            self.tableView.reloadData()
            PersistenceManager.shared.saveContext()
        }))
        
        present(alert, animated: true)
    }
    
    private func scanReceipt() {
        let documentCameraVC = VNDocumentCameraViewController()
        documentCameraVC.delegate = self
        
        present(documentCameraVC, animated: true)
    }
    
    private func bringSubviewsToFront() {
        view.bringSubviewToFront(activityIndicator)
        view.bringSubviewToFront(addItemsButton)
    }
    
}


extension AddItemsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if items.isEmpty {
            DispatchQueue.main.async {
                self.showEmptyStateView(message: "No items", in: self.view)
                self.bringSubviewsToFront()
            }
        }else {
            DispatchQueue.main.async {
                self.view.bringSubviewToFront(self.tableView)
                self.bringSubviewsToFront()
            }
        }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddItemCell.identifier) as! AddItemCell
        cell.set(item: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AddItemCell
        cell.toggeSelection()
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [createDeleteAction(indexPath: indexPath)])
    }
    
    private func createDeleteAction(indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            guard let self = self else {
                completion(false)
                return
            }
            
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
        }
    }

}


extension AddItemsVC: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        activityIndicator.startAnimating()
        
        controller.dismiss(animated: true) { [weak self] in
            DispatchQueue.global(qos: .userInitiated).async {
                for pageNumber in 0 ..< scan.pageCount {
                    let image = scan.imageOfPage(at: pageNumber)
                    self?.processImage(image: image)
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func processImage(image: UIImage) {
        guard let cgImage = image.cgImage else {
            print("Failed to get cgimage from input image")
            return
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try handler.perform([textRecognitionRequest])
        } catch {
            print(error)
        }
    }
    
    private func configureTextRecognitionRequest() {
        textRecognitionRequest = VNRecognizeTextRequest(completionHandler: { [weak self] (request, error) in
            if let results = request.results, !results.isEmpty {
                if let requestResults = request.results as? [VNRecognizedTextObservation] {
                    self?.addTextObservations(recognizedText: requestResults)
                }
            }
        })
        
        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.recognitionLanguages = ["en-US"]
        textRecognitionRequest.usesLanguageCorrection = true
    }
    
    private func addTextObservations(recognizedText: [VNRecognizedTextObservation]) {
        var lines = filterTextObservations(recognizedText)
        filterRecognizedText(&lines)
        addRecognizedText(lines)
    }
    
    private func filterTextObservations(_ recognizedText: [VNRecognizedTextObservation]) -> [[VNRecognizedText]] {
        let observations = recognizedText.sorted(by: {$0.boundingBox.maxY > $1.boundingBox.maxY})

        var lines = [[VNRecognizedText]]()
        var rects = [CGRect]()
        
        for observation in observations {
            guard let candidate = observation.topCandidates(1).first else { continue }
            
            let centerY = (observation.boundingBox.minY + observation.boundingBox.maxY) / 2
            
            if let rect = rects.last, rect.minY <= centerY, centerY <= rect.maxY {
                lines[lines.count - 1].append(candidate)
            }else {
                rects.append(observation.boundingBox)
                lines.append([candidate])
            }
        }
        
        return lines
    }
    
    private func filterRecognizedText(_ lines: inout [[VNRecognizedText]]) {
        lines = lines.filter({ [weak self] in
            guard let self = self else { return false }
            
            for text in $0 {
                if self.isPriceTag(text: text.string) {
                    return true
                }
            }
            return false
        })
    }
    
    private func addRecognizedText(_ lines: [[VNRecognizedText]]) {
        for line in lines {
            var name = ""
            var price: Float = 0
            
            for text in line {
                if isPriceTag(text: text.string) {
                    let negative = text.string.contains("-")
                    
                    price = extractPrice(text: text.string)
                    
                    if negative {
                        price = -price
                    }
                }else {
                    name += text.string
                }
            }
            
            if price == 0 { continue }
            
            if name.uppercased().contains("SUBTOTAL") {
                break
            }
            
            let item = Item(context: PersistenceManager.shared.context)
            item.name = name
            item.value = price
            
            items.append(item)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func extractPrice(text: String) -> Float {
        do {
            let regex = try NSRegularExpression(pattern: pricePattern, options: [])
            if let match = regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
                if let price = Float((text as NSString).substring(with: match.range)) {
                    return price
                }
            }
        } catch {
            print(error)
        }
        return 0
    }
    
    private func isPriceTag(text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: priceTagPattern, options: [])
            if let _ = regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
}
