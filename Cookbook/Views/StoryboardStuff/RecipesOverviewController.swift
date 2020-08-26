//
//  RecipesOverviewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 23.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "Cell"

class RecipesOverviewController: UIViewController {
    
    var recipes = Store.shared.recipes
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
//    var collectionCellWidth: CGFloat {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
//        clearsSelectionOnViewWillAppear = false
        
        // Gets informed when recipe changes occure.
        NotificationCenter.default.addObserver(self, selector: #selector(recipeChanges(notification:)), name: Store.RecipesStoreUpdate.recipesStoreUpdateNotificationName, object: nil)
        
        configureCollectionView()
        configureSearchBar()
    }
    
    private func configureCollectionView() {
        
        collectionView.register(UINib(nibName: "RecipeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
    }
    
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        searchBar.tintColor = .white
        searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    @objc private func recipeChanges(notification: Notification) {
        collectionView.reloadData()
    }
}



// MARK: - NavigationBar Items
extension RecipesOverviewController {
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
}



// MARK: - CollectionView Delegate
extension RecipesOverviewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select recipe \(recipes[indexPath.row].title ?? "\(indexPath.row)")")
    }
}



// MARK: - CollectionView DataSource
extension RecipesOverviewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        guard let recipeCell = cell as? RecipeCollectionViewCell else { return cell }
        
         recipeCell.layer.shadowRadius = 5
        
        let recipe = recipes[indexPath.row]
        recipeCell.setData(for: recipe)
        
        return recipeCell
    }
}



extension RecipesOverviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let horizontalInset = (collectionView.frame.width - collectionView.frame.width * 0.7) / 2
        
        return UIEdgeInsets(top: 16, left: horizontalInset, bottom: 16, right: horizontalInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width * 0.7 > 300 ? 300 : collectionView.frame.width * 0.7
        let height = collectionView.frame.height * 0.7 > 500 ? 500 : collectionView.frame.height * 0.7
        
        return CGSize(width: width * 0.7, height: height)
    }
}



// MARK: - SearchBar
extension RecipesOverviewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        #if DEBUG
        print("Text changed")
        #endif
        if searchText.trimmingCharacters(in: .whitespaces) == "" {
            recipes = Store.shared.recipes
        }
        else {
            recipes = recipes.filter { recipe in
                let searchString = "\(recipe.title ?? "")"
                return searchString.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        #if DEBUG
        print("Cancel button clicked")
        #endif
        recipes = Store.shared.recipes
    }
}
