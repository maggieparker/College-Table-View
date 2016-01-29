import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var myTableView: UITableView!
    var colleges: [University] = []

    override func viewDidLoad()
        {
            
            super.viewDidLoad()
            myTableView.dataSource = self
            myTableView.delegate = self
        
            colleges.append(University(Name: "Univeristy Of Illinois", Location: "Urbana-Chapaigne, Illinois", Students: 44000, Picture: UIImage(named: "Illinois")!))
            colleges.append(University(Name: "Univeristy Of Oregon", Location: "Eugene, Oregon", Students: 24000, Picture: UIImage(named: "Oregon")!))
            colleges.append(University(Name: "Colorado University", Location: "Boulder, Colorado", Students: 30000, Picture: UIImage(named: "Colorado")!))
        }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
            let myTableViewCell = myTableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as UITableViewCell
            myTableViewCell.textLabel?.text = colleges[indexPath.row].name
            myTableViewCell.detailTextLabel?.text = colleges[indexPath.row].location
            return myTableViewCell
        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) ->Int
        {
            return colleges.count
        }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
        {
            if editingStyle == .Delete
            {
                colleges.removeAtIndex(indexPath.row)
                myTableView.reloadData()
            }
        }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let professor = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(professor, atIndex: destinationIndexPath.row)
    }
    
    
    @IBAction func editButtonTapped(sender: UIBarButtonItem )
    {
        myTableView.editing = !myTableView.editing
    }

    @IBAction func addButton(sender: AnyObject)
        {
            let myAlert = UIAlertController(title: "Add College", message: nil, preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            myAlert.addAction(cancelAction)
        
            let addAction = UIAlertAction(title: "Add", style: .Default) { (addAction) -> Void in
                let collegeTextField = myAlert.textFields![0] as UITextField
                let locationTextField = myAlert.textFields![1]
                self.colleges.append(University(Name: collegeTextField.text!, Location: locationTextField.text!))
                self.myTableView.reloadData()
            
        }
            myAlert.addAction(addAction)
            myAlert.addTextFieldWithConfigurationHandler { (collegeTextField) -> Void in
                collegeTextField.placeholder = "Add College Name"
            }
         
            myAlert.addTextFieldWithConfigurationHandler { (locationTextField) -> Void in
                locationTextField.placeholder = "Add the location"
            }
            
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let detailVC = segue.destinationViewController as!DetailViewController
        let selectRow = myTableView.indexPathForSelectedRow?.row
        detailVC.student = colleges[selectRow!]
    }
}
