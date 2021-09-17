//
//  ViewController.swift
//  Demo_InitialD_HV
//
//  Created by 蔡忠翊 on 2021/9/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = generateLayout()
        
        self.collectionView.isScrollEnabled = false
        // 值得注意的，剛剛的例子是 section 裡的內容可以水平捲動，但
        // collection view 本身還是垂直捲動。若想將 collection view 本身的捲動關掉，
        // 記得要將它的 isScrollEnabled 設為 false
    }
    
    /* 控制內容的捲動方向 */
    // 方法1: 設定 UICollectionViewCompositionalLayoutConfiguration 的 scrollDirection
    //    func generateLayout() -> UICollectionViewLayout {
    //        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .fractionalHeight(1))
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(250), heightDimension: .fractionalHeight(1))
    //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //        let section = NSCollectionLayoutSection(group: group)
    //
    //        let configuration = UICollectionViewCompositionalLayoutConfiguration()
    //        configuration.scrollDirection = .horizontal
    //        return UICollectionViewCompositionalLayout(section: section, configuration: configuration)
    //    }
    
    // 方法 2: 設定 section 的 orthogonalScrollingBehavior
    
    //    func generateLayout() -> UICollectionViewLayout {
    //        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .fractionalHeight(1))
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(250), heightDimension: .fractionalHeight(1))
    //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //        let section = NSCollectionLayoutSection(group: group)
    //
    //        // 控制捲動行為的 orthogonalScrollingBehavior，分頁和露出前一個 / 下一個的部分內容
    //        // continuous 畫面水平捲動，可停留在任何一個位置，沒有分頁的效果
    //        section.orthogonalScrollingBehavior = .continuous
    //        return UICollectionViewCompositionalLayout(section: section)
    //    }
    
    // paging 畫面水平捲動，搭配分頁效果，分頁的寬度是 collection view 的寬度
    //    func generateLayout() -> UICollectionViewLayout {
    //        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //        let section = NSCollectionLayoutSection(group: group)
    //        section.interGroupSpacing = 10
    //        // 不過當 group 之間有間距時，剛剛的分頁效果卻會產生問題。因為 paging 時分頁的寬度是 collection view 的寬度，因此滑動後我們會看到間距露出來
    //        section.orthogonalScrollingBehavior = .paging
    //        return UICollectionViewCompositionalLayout(section: section)
    //    }
    
    // groupPaging 可解決剛剛的問題，它的分頁將以 group 為單位，滑動停止時將剛好顯示 group 的起點
    //    func generateLayout() -> UICollectionViewLayout {
    //            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    //            let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    //            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //            let section = NSCollectionLayoutSection(group: group)
    //            section.interGroupSpacing = 10
    //            section.orthogonalScrollingBehavior = .groupPaging
    //            return UICollectionViewCompositionalLayout(section: section)
    //    }
    
    // groupPaging 露出下一個的部分內容: groupPaging
    //    func generateLayout() -> UICollectionViewLayout {
    //        let space: Double = 10
    //        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        // group 的寬度是 collection view 寬度的 0.9 倍，因此畫面上將露出下一個的部分內容
    //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1))
    //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //        let section = NSCollectionLayoutSection(group: group)
    //        section.interGroupSpacing = space
    //        section.orthogonalScrollingBehavior = .groupPaging
    //        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: space, bottom: 0, trailing: space)
    //        return UICollectionViewCompositionalLayout(section: section)
    //    }
    
    // 露出上一個 / 下一個的部分內容: groupPagingCentered
    // 不只是露出下一個，我們也可以露出上一個的部分內容。我們可以改用 groupPagingCentered。滑動停止時它將讓 group 置中，因此前一個跟下一個都可以露出。(ps: 以下例子若採用 interGroupSpacing 設定間距會出問題，因此要從 item 的 contentInsets 設間距，間距將是 space * 2）
    //    func generateLayout() -> UICollectionViewLayout {
    //        let space: Double = 5
    //        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: space, bottom: 0, trailing: space)
    //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1))
    //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //        let section = NSCollectionLayoutSection(group: group)
    //        section.orthogonalScrollingBehavior = .groupPagingCentered
    //        return UICollectionViewCompositionalLayout(section: section)
    //    }
    
    /* continuousGroupLeadingBoundary */
    // 最後還有一個特別的捲動效果 continuousGroupLeadingBoundary，它同時具有快速滑動跟分頁的優點
    // 它可以快速滑動，不像分頁一次只能滑一個
    // 當滑動停止時，它將剛好停在 group 的起點，所以圖片不會被切到
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: "Image\(indexPath.item + 1)")
        return cell
    }
    
}
