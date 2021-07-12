//
//  DiaryVC.swift
//  myFitness
//
//  Created by 楊振東 on 2021/7/10.
//

import UIKit
import CoreData

class DiaryVC: UITableViewController,NSFetchedResultsControllerDelegate {
    
    var fetchResultController : NSFetchedResultsController<DiaryMO>!
    @IBOutlet var emptyDiaryView: UIView!
    var diarys:[DiaryMO] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name: "Rubik-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0), NSAttributedString.Key.font: customFont]
        }
        navigationController?.hidesBarsOnSwipe = true
        
        tableView.backgroundView = emptyDiaryView
        tableView.backgroundView?.isHidden = true
        
        // Fetch data from data store
        let fetchRequest: NSFetchRequest<DiaryMO> = DiaryMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    diarys = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if diarys.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diarys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "diarycell", for: indexPath) as! DiaryTableViewCell
        cell.nameLabel.text = diarys[indexPath.row].name
        cell.dateLabel.text = diarys[indexPath.row].date
        if let diaryImage = diarys[indexPath.row].image {
            cell.thumbnailImageVew.image = UIImage(data: diaryImage as Data)
        }
        cell.heartImageView.isHidden = !self.diarys[indexPath.row].isLike
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false) //閃一下
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            // Delete the row from the data store
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let diaryToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(diaryToDelete)
                
                appDelegate.saveContext()
            }
            
            // Call completion handler with true to indicate
            completionHandler(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") { (action, sourceView, completionHandler) in
            let defaultText = "Share my training plan: " + self.diarys[indexPath.row].name!
            
            let activityController: UIActivityViewController
            
            if let diaryImage = self.diarys[indexPath.row].image,
                let imageToShare = UIImage(data: diaryImage as Data) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else  {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            self.present(activityController, animated: true, completion: nil)
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor.red
        deleteAction.image = UIImage(systemName: "trash")
        shareAction.backgroundColor = UIColor.orange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction,shareAction])
        return swipeConfiguration
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let likeAction = UIContextualAction(style: .normal, title: "Like") { (action, sourceView, completionHandler) in
            
            let cell = tableView.cellForRow(at: indexPath) as! DiaryTableViewCell
            self.diarys[indexPath.row].isLike = (self.diarys[indexPath.row].isLike) ? false : true
            cell.heartImageView.isHidden = self.diarys[indexPath.row].isLike ? false : true
            
            completionHandler(true)
        }
        
        let likeIcon = diarys[indexPath.row].isLike ? "arrow.uturn.left" : "heart.circle"
        likeAction.backgroundColor = UIColor(red: 38.0/255.0, green: 162.0/255.0, blue: 78.0/255.0, alpha: 1.0)
        likeAction.image = UIImage(systemName: likeIcon)
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [likeAction])
        
//        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
//            appDelegate.saveContext()
//        }
        
        return swipeConfiguration
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDiaryDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DiaryDetailVC
                destinationController.diary = diarys[indexPath.row]
                
                
            }
        }
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - NSFetchedResultsControllerDelegate methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            diarys = fetchedObjects as! [DiaryMO]
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }



    


 

}
