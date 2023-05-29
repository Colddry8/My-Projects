//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Денис Глущенко on 17/5/2566 BE.
//

import UIKit

// MARK: ListViewcontroller
class ListViewController: UITableViewController {

    // MARK: ListViewControllerOutlets
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var pinButton: UIBarButtonItem!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            //Refresh table contents on view load
        }
        
 
    // MARK: IBAction logout
    @IBAction func logout(_ sender: Any) {
        UdacityClient.logout(completion: handleLogoutResponse(success:error:))
    }
    
    // MARK: IBAction refresh
    @IBAction func refresh(_ sender: Any) {
        UdacityClient.getStudentInformation(completion: handleGetStudentInformation(data:error:))
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: IBAction addPinLocation
    @IBAction func addPinLocation(_ sender: Any) {
        let addPinVC =
            storyboard?.instantiateViewController(withIdentifier: "addLocation") as! AddPinViewController
            present(addPinVC, animated: true, completion: nil)
    }
    
    // MARK: tableViewNumberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentModel.data.count
    }
    
    // MARK: tableViewCellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell") as! TableViewCell
        cell.nameLabel?.text = StudentModel.data[(indexPath as NSIndexPath).row].firstName + " " + StudentModel.data[(indexPath as NSIndexPath).row].lastName
        cell.locationLabel?.text = StudentModel.data[(indexPath as NSIndexPath).row].mediaURL
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
        let selectedStudent = StudentModel.data[selectedIndex]
        let studentLinkString = selectedStudent.mediaURL
        if let studentURL = URL(string: studentLinkString)
        {
            UIApplication.shared.open(studentURL, options: [:], completionHandler: nil)
        } else {
            showFailure(title: "No URL", message: "URL isn't valid")
        }
    }
    // MARK: HandleGetStudentInformation
    func handleGetStudentInformation(data: [StudentLocation], error: Error?)
    {
        if error == nil
        {
            StudentModel.data = data
        } else
        {
            showFailure(title: "Location Data error", message: error?.localizedDescription ?? "")
        }
    }
    
    // MARK: handleLogoutResponse
    func handleLogoutResponse(success: Bool, error: Error?) {
        if success {
            self.dismiss(animated: true, completion: nil)
        } else {
            showFailure(title: "Logout Failed", message: error?.localizedDescription ?? "")
        }
    }
  
}
