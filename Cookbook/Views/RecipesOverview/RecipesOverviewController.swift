//
//  RecipesOverviewController.swift
//  Cookbook
//
//  Created by Marlo Kessler on 23.08.20.
//  Copyright © 2020 Marlo Kessler. All rights reserved.
//

import UIKit
import CoreData
import SwiftExtensions

class RecipesOverviewController: UIViewController, Storyboarded {
    
    var coordinator: RecipesCoordinatorProtocol?
    
    var recipes = RecipesStore.shared.values
    
    private let reuseIdentifier = "RecipeCollectionViewCell"
    
    private var isInEditMode = false {
        didSet {
            updateAppearance()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets informed when recipe changes occure.
        NotificationCenter.default.addObserver(self, selector: #selector(recipeChanges(notification:)), name: RecipesStore.Update.notificationName, object: nil)
        
        sortRecipes()
        configureCollectionView()
//        configureSearchBar()
        updateAppearance()
    }
    
    
    private func updateAppearance() {
        
        updateNavBar()
        
        collectionView.visibleCells.forEach { cell in
            guard let cell = cell as? RecipeCollectionViewCell else { return }
            cell.isInEditMode = isInEditMode
        }
    }
    
    
    //  MARK: CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let sectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private let itemsSpacing  = ItemsSpacing(horizontal: 16, vertical: 16)
    
    private func configureCollectionView() {
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = itemsSpacing.horizontal
        
        collectionView.collectionViewLayout = layout
    }
}



// MARK: - Recipes Management
extension RecipesOverviewController {
    @objc private func recipeChanges(notification: Notification) {
        #if DEBUG
        print("Received a \"recipes changed\" notification in \(String(describing: self)).")
        #endif
        guard let change = notification.object as? RecipesStore.Update else { return }
        
        setRecipesFromStore()
        
        switch change {
            
        case .added(_):
            collectionView.reloadData()
            updateNavBar()
            
        case .changed(_): collectionView.reloadData()
            
        case .deleted(_): updateNavBar()
        }
    }
    
    private func setRecipesFromStore() {
        #if DEBUG
        print("Set recipes from store")
        #endif
        recipes = RecipesStore.shared.values
        sortRecipes()
    }
    
    private func sortRecipes() {
        #if DEBUG
        print("Sort recipes")
        #endif
        recipes.sort(by: { $0.title ?? "" < $1.title ?? "" })
    }
    
    private func filterRecipes(by filter: (Recipe) -> Bool) {
        recipes = recipes.filter(filter)
    }
}



// MARK: - NavigationBarItems
extension RecipesOverviewController {
    func updateNavBar() {
        setNavTitleView()
        setBarButtonItems()
    }
    
    private func setNavTitleView() {
        // In order to center the title view image no matter what buttons there are, do not set the
        // image view as title view, because it doesn't work. If there is only one button, the image
        // will not be aligned. Instead, a content view is set as title view, then the image view is
        // added as child of the content view. Finally, using constraints the image view is aligned
        // inside its parent.
        let contentView = UIView()
        self.navigationItem.titleView = contentView
        
        let imageView         = UIImageView(image: #imageLiteral(resourceName: "CookbookIcon"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView?.addSubview(imageView)

        // Setting a top and bottom constraint does not size properly, because containerview is not bound to navbar.
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func setBarButtonItems() {
        var rightBarButtonItems = [UIBarButtonItem]()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addButtonPressed(sender:)))
        rightBarButtonItems.append(addButton)
        
        if recipes.count > 0 {
            let editButton = UIBarButtonItem(barButtonSystemItem: isInEditMode ? .done : .edit, target: self, action: #selector(self.editButtonPressed(sender:)))
            rightBarButtonItems.append(editButton)
        }
        
        self.navigationItem.setRightBarButtonItems(rightBarButtonItems, animated: true)
    }
        
    @objc func editButtonPressed(sender: UIBarButtonItem) {
        #if DEBUG
        print("Edit button pressed")
        #endif
        isInEditMode.toggle()
    }
    
    @objc func addButtonPressed(sender: UIBarButtonItem) {
        #if DEBUG
        print("Add button pressed")
        #endif
        isInEditMode = false
        coordinator?.createRecipe()
    }
}



// MARK: - SearchBar
extension RecipesOverviewController {
    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        let searchBar = searchController.searchBar
        searchBar.tintColor = .white
        searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}



// MARK: - UISearchBarDelegate
extension RecipesOverviewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        #if DEBUG
        print("SearchBar text changed")
        #endif
        if searchText.trimmingCharacters(in: .whitespaces) == "" {
            setRecipesFromStore()
        }
        else {
            filterRecipes { recipe in
                let searchString = "\(recipe.title ?? "")"
                return searchString.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        #if DEBUG
        print("SearchBar cancel button clicked")
        #endif
        setRecipesFromStore()
        collectionView.reloadData()
    }
}



// MARK: - UICollectionViewDelegate
extension RecipesOverviewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        #if DEBUG
        print("Did select recipe \(recipes[indexPath.row].title ?? "\(indexPath.row)")")
        #endif
        let selectedRecipe = recipes[indexPath.row]
                
        coordinator?.show(selectedRecipe, inEditMode: false, animated: true)
    }
}



// MARK: - UICollectionViewDataSource
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
                
        recipeCell.delegate = self
        recipeCell.recipe = recipes[indexPath.row]
        recipeCell.indexPath = indexPath
        recipeCell.isInEditMode = isInEditMode
                
        return recipeCell
    }
}



// MARK: - UICollectionViewDelegateFlowLayout
extension RecipesOverviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat
        let height: CGFloat
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            width = collectionView.frame.width - 2 * (sectionInsets.left + sectionInsets.right)
            height = collectionView.frame.height - 2 * (sectionInsets.top + sectionInsets.bottom)
            
        } else {
            // Calc height
            let itemMinHeight: CGFloat = 300
            
            var itemsPerRow = 1
            
            var heightRest = collectionView.frame.height - (sectionInsets.top + sectionInsets.bottom)
            
            if heightRest - itemMinHeight > 0 {
                heightRest -= itemMinHeight
                
                while heightRest - (itemMinHeight + itemsSpacing.vertical) > 0 {
                    heightRest -= (itemMinHeight + itemsSpacing.vertical)
                    itemsPerRow += 1
                }
            }
            
            let heightPadding = sectionInsets.top + sectionInsets.bottom + itemsSpacing.vertical * CGFloat((itemsPerRow - 1))
            height = (collectionView.frame.height - heightPadding) / CGFloat(itemsPerRow)
            
            // Calc width
            width = height * 3/4
        }
        
        return CGSize(width: width, height: height)
    }
}



// MARK: - RecipeCollectionViewCellDelegate
extension RecipesOverviewController: RecipeCollectionViewCellDelegate {
    
    func didPressDeleteButton(for recipe: Recipe, at indexPath: IndexPath) {
        let message = String(format: "Do you really want to delete \"%@\"?".localized(), recipe.title ?? "")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete Recipe".localized(), style: .destructive) { _ in
            self.delete(recipe, at: indexPath)
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func delete(_ recipe: Recipe, at indexPath: IndexPath) {
        self.collectionView.performBatchUpdates({
            RecipesStore.shared.delete(recipe)
            self.collectionView.deleteItems(at: [indexPath])
        }, completion: { _ in
            // Necerssary, because otherwise errors occures due to unknown reasons.
            // TODO: Find the reasons, why those errors occure.
            self.collectionView.reloadData()
        })
    }
}
