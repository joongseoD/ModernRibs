//
//  CardOnFileDashboardViewController.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/10/26.
//

import ModernRIBs
import UIKit

protocol CardOnFileDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class CardOnFileDashboardViewController: UIViewController, CardOnFileDashboardPresentable, CardOnFileDashboardViewControllable {

    weak var listener: CardOnFileDashboardPresentableListener?
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "슈퍼페이 잔고"
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("전체보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let cardonFileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var addMethodButton: AddPaymentMethodButton = {
        let button = AddPaymentMethodButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundCorners()
        button.backgroundColor = .systemGray4
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(headerStackView)
        view.addSubview(cardonFileStackView)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(seeAllButton)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cardonFileStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
            cardonFileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardonFileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardonFileStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addMethodButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    @objc
    func seeAllButtonTapped() {
        
    }
    
    @objc
    func addButtonDidTap() {
        
    }
    
    func update(with viewModels: [PaymentMethodViewModel]) {
        cardonFileStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let views = viewModels.map(PaymentMethodView.init)
        
        views.forEach {
            $0.roundCorners()
            cardonFileStackView.addArrangedSubview($0)
        }
        
        cardonFileStackView.addArrangedSubview(addMethodButton)
        let heightConstraints = views.map { $0.heightAnchor.constraint(equalToConstant: 60) }
        NSLayoutConstraint.activate(heightConstraints)
    }
}
