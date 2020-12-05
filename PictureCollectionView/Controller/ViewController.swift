//
//  ViewController.swift
//  PictureCollectionView
//
//  Created by Matvei  on 01.12.2020.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var lineStation = [MLines]()
    
    private let spacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configure()

    }
    
    private func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self

    }

    private func loadData(){
        NetworkService.loadData { (lineStation, error) in
            if let error = error{
                self.showAlert(title: error.localizedDescription)
            }
            self.lineStation = lineStation
            self.collectionView.reloadData()

        }
    }
    
    private func showAlert(title: String){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStationsVC"{
            guard let stationVC = segue.destination as? StationTableViewController,
            let stations = sender as? [MStations]
            else{
                fatalError("Incorrect data passed")
            }
            stationVC.stations = stations
        }
    }
}



extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lineStation.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewImage.identifier, for: indexPath) as? CollectionViewImage else {
            fatalError("Invalid Cell kind")
        }
        
        cell.configure(with: UIColor.fromHex(lineStation[indexPath.row].hex_color), lineStation: lineStation, indexPath: indexPath.row)

        return  cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfItemsPerRow: CGFloat = 2

        let width = view.bounds.width
        let summarySpacing = spacing * (numberOfItemsPerRow - 1)
        let insets = 2 * spacing
        let rawWidth = width - summarySpacing - insets

        let cellWidth = rawWidth / numberOfItemsPerRow

        return CGSize(width: cellWidth, height: cellWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stations = lineStation[indexPath.row].stations
        performSegue(withIdentifier: "ShowStationsVC", sender: stations)
    }
}
