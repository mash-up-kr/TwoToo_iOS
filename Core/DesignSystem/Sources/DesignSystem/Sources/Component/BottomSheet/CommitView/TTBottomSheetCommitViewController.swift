//
//  TTBottomSheetCommitViewController.swift
//  
//
//  Created by Julia on 2023/06/23.
//

import UIKit

public final class TTBottomSheetCommitViewController: UIViewController, ScrollableViewController {
    
    public var scrollView: UIScrollView {
        self.backScrollView
    }
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.text = "인증하기"
        v.font = .systemFont(ofSize: 20, weight: .bold)
        v.textAlignment = .center
        v.textColor = .black
        v.backgroundColor = .brown
        return v
    }()
    
    private lazy var commitPhotoView: UIView = {
        let v = UIView() // 수정 필요
        v.backgroundColor = .green
        return v
    }()
    
    private lazy var commentTextField: UITextField = {
        let v = UITextField()
        v.placeholder = "소감을 작성해 주세요."
        v.font = .systemFont(ofSize: 12)
        v.textColor = .gray
        v.backgroundColor = .yellow
        return v
    }()
    
    // TODO: 컴포넌트 버튼으로 변경필요
    private lazy var commitButton: UIButton = {
        let v = UIButton()
        v.setTitle("인증 하기", for: .normal)
        v.backgroundColor = .orange
        return v
    }()
    
    private lazy var scrollStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.spacing = 16
        v.distribution = .fill
        [self.titleLabel, self.commitPhotoView, self.commitButton, self.commentTextField, self.commitButton].forEach {
            v.addArrangedSubview($0)
        }
        return v
    }()
    
    private lazy var backScrollView: UIScrollView = {
        let v = SelfSizingScrollView(maxHeight: UIScreen.main.bounds.height * 0.7)
        v.addSubview(self.scrollStackView)
        return v
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        view.addSubview(self.backScrollView)
        
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        self.commitPhotoView.snp.makeConstraints { make in
            make.height.equalTo(312)
        }
        
        self.commentTextField.snp.makeConstraints { make in
            make.height.equalTo(85)
        }

        self.commitButton.snp.makeConstraints { make in
            make.height.equalTo(57)
        }

        //스택뷰
        self.scrollStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().inset(14)
            make.width.equalToSuperview().inset(24)

        }
        
        //스크롤뷰
        self.backScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
