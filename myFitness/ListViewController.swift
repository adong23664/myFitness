//
//  ListViewController.swift
//  myFitness
//
//  Created by 楊振東 on 2021/6/17.
//新addNote 刪commit editing 改 didFinishUpdate

import UIKit
import CoreData

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NoteViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var data : [Note] = []
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.queryFromDB()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        self.tableView.setEditing(editing, animated: true)
    }
    @objc
    @IBAction func addNote(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd hh:mm"
        let todayString = formatter.string(from: Date())
        let moc = CoreDataHelper.shared.managedObjectContext()
        let note = Note(context: moc)
        note.text = "\(todayString)\n訓練項目:\n內容:\n..."
        CoreDataHelper.shared.saveContext()  //把資料存到sqlite
        self.data.insert(note, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }

    //MARK: CoreData
    
    func queryFromDB() {
        let moc = CoreDataHelper.shared.managedObjectContext()  //負責查詢
        let request = NSFetchRequest<Note>(entityName: "Note")
        
        
        moc.performAndWait {
            do{
                let result = try moc.fetch(request)
                self.data = result
            } catch {
                print("error query db \(error)")
                self.data = []
            }
        }
    }
    
    func saveToDB() {
        //...
    }
    
    
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = self.data[indexPath.row]
        cell.textLabel?.text = note.text
        cell.imageView?.image = note.thumbnail()
        cell.showsReorderControl = true
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let note = self.data.remove(at: indexPath.row)
            let moc = CoreDataHelper.shared.managedObjectContext()
            moc.performAndWait {
                moc.delete(note)
            }
            CoreDataHelper.shared.saveContext()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let note = self.data.remove(at: sourceIndexPath.row)
        self.data.insert(note, at: destinationIndexPath.row)
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("選\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteSegue" {
            if let noteVC = segue.destination as? NoteViewController, let indexPath = self.tableView.indexPathForSelectedRow{
                let note = self.data [indexPath.row]
                noteVC.currentNote = note
                noteVC.delegate = self
            }
        }
    }
    
    func didFinishUpdate(note : Note){
        print("note updated: \(note.text!)")
        CoreDataHelper.shared.saveContext()
        if let index = self.data.firstIndex(of: note) {
            let indexPath = IndexPath(item: index, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
