//
//  MessageCell.swift
//  LarkClone
//
//  Created by 张纪龙 on 2025/5/11.
//

import UIKit
import LarkColor
import LarkChatBubble

class MessageCell: UITableViewCell {
    
    // MARK: - Properties
    private let bubbleView = ChatBubbleView()
    private let timeLabel = UILabel()
    private let readStatusView = UIImageView()
    private let avatarImageView = UIImageView()
    private let senderNameLabel = UILabel()
    private let screenWidth = UIScreen.main.bounds.width
    private var registrationToken: NSObjectProtocol?
    
    // 常量
    private struct Constants {
        static let avatarSize: CGFloat = 36
        static let avatarMargin: CGFloat = 8
        static let maxBubbleWidth: CGFloat = 0.65 // 屏幕宽度的百分比
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        registerForTraitChanges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let token = registrationToken {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // 基本设置
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        
        // 配置头像
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = Constants.avatarSize / 2
        avatarImageView.clipsToBounds = true
        avatarImageView.backgroundColor = LarkColorStyle.Avatar.backgroundColor
        contentView.addSubview(avatarImageView)
        
        // 配置发送者名称
        senderNameLabel.font = UIFont.systemFont(ofSize: 12)
        senderNameLabel.textColor = LarkColorStyle.Text.secondary
        contentView.addSubview(senderNameLabel)
        
        // 添加气泡视图
        contentView.addSubview(bubbleView)
        
        // 配置时间标签
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.textColor = LarkColorStyle.Text.secondary
        contentView.addSubview(timeLabel)
        
        // 配置已读状态视图
        readStatusView.contentMode = .scaleAspectFit
        readStatusView.tintColor = LarkColorStyle.ReadStatus.tintColor
        contentView.addSubview(readStatusView)
        
        // 设置自动布局
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        senderNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        readStatusView.translatesAutoresizingMaskIntoConstraints = false
        
        // 设置基础约束
        NSLayoutConstraint.activate([
            // 头像约束
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarSize),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarSize),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            // 发送者名称约束
            senderNameLabel.heightAnchor.constraint(equalToConstant: 16),
            
            // 气泡约束
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: screenWidth * Constants.maxBubbleWidth),
            
            // 时间标签约束
            timeLabel.topAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: 2),
            timeLabel.heightAnchor.constraint(equalToConstant: 15),
            
            // 已读状态约束
            readStatusView.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            readStatusView.widthAnchor.constraint(equalToConstant: 12),
            readStatusView.heightAnchor.constraint(equalToConstant: 12),
            
            // 底部约束
            contentView.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8)
        ])
    }
    
    // MARK: - Configuration
    func configure(with message: Message) {
        removeConstraintsWithIdentifier("dynamicConstraint")
        
        // 设置消息内容
        bubbleView.configure(text: message.content, type: message.type == .sent ? .sent : .received)
        timeLabel.text = message.formattedTime()
        
        // 根据消息类型设置头像
        if message.type == .sent {
            if let customAvatar = UIImage(named: "zhang-jilong") {
                avatarImageView.image = customAvatar
            } else {
                // 如果找不到，使用message中的头像或默认头像
                avatarImageView.image = message.sender.avatar
            }
        } else {
            // 接收的消息使用原始头像
            avatarImageView.image = message.sender.avatar
        }
        
        // 根据消息类型设置布局
        if message.type == .sent {
            configureSentMessage(message)
        } else {
            configureReceivedMessage(message)
        }
        
        // 确保所有约束应用后重新布局
        self.contentView.layoutIfNeeded()
    }
    
    private func configureSentMessage(_ message: Message) {
        // 明确隐藏发送者名称
        senderNameLabel.isHidden = true
        avatarImageView.isHidden = false
        
        // 设置已读状态
        readStatusView.isHidden = false
        
        // 设置已读状态图标颜色
        let readImageConfig = UIImage.SymbolConfiguration(weight: .light)
        readStatusView.image = message.isRead ?
            UIImage(systemName: "checkmark.circle.fill", withConfiguration: readImageConfig)?.withRenderingMode(.alwaysTemplate) :
            UIImage(systemName: "checkmark.circle", withConfiguration: readImageConfig)?.withRenderingMode(.alwaysTemplate)
        
        // 使用更明亮的绿色
        readStatusView.tintColor = LarkColorStyle.ReadStatus.tintColor
        
        // 右侧约束 - 头像在右边
        let avatarRightConstraint = avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.avatarMargin)
        avatarRightConstraint.identifier = "dynamicConstraint"
        
        let bubbleRightConstraint = bubbleView.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -Constants.avatarMargin)
        bubbleRightConstraint.identifier = "dynamicConstraint"
        
        let bubbleTopConstraint = bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        bubbleTopConstraint.identifier = "dynamicConstraint"
        
        let timeRightConstraint = timeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor)
        timeRightConstraint.identifier = "dynamicConstraint"
        
        let readStatusRightConstraint = readStatusView.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -4)
        readStatusRightConstraint.identifier = "dynamicConstraint"
        
        NSLayoutConstraint.activate([
            avatarRightConstraint,
            bubbleRightConstraint,
            bubbleTopConstraint,
            timeRightConstraint,
            readStatusRightConstraint
        ])
    }
    
    private func configureReceivedMessage(_ message: Message) {
        // 明确显示发送者名称和头像
        senderNameLabel.isHidden = false
        senderNameLabel.text = message.sender.name
        avatarImageView.isHidden = false
        
        // 明确隐藏已读状态
        readStatusView.isHidden = true
        
        // 左侧约束 - 头像在左边
        let avatarLeftConstraint = avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.avatarMargin)
        avatarLeftConstraint.identifier = "dynamicConstraint"
        
        let nameLeftConstraint = senderNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.avatarMargin)
        nameLeftConstraint.identifier = "dynamicConstraint"
        
        let nameTopConstraint = senderNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4)
        nameTopConstraint.identifier = "dynamicConstraint"
        
        let nameRightConstraint = senderNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.avatarMargin)
        nameRightConstraint.identifier = "dynamicConstraint"
        
        let bubbleLeftConstraint = bubbleView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.avatarMargin)
        bubbleLeftConstraint.identifier = "dynamicConstraint"
        
        let bubbleTopConstraint = bubbleView.topAnchor.constraint(equalTo: senderNameLabel.bottomAnchor, constant: 4)
        bubbleTopConstraint.identifier = "dynamicConstraint"
        
        let timeLeftConstraint = timeLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor)
        timeLeftConstraint.identifier = "dynamicConstraint"
        
        NSLayoutConstraint.activate([
            avatarLeftConstraint,
            nameLeftConstraint,
            nameTopConstraint,
            nameRightConstraint,
            bubbleLeftConstraint,
            bubbleTopConstraint,
            timeLeftConstraint
        ])
    }
    
    // MARK: - 暗色模式支持
    private func registerForTraitChanges() {
        if #available(iOS 17.0, *) {
            registrationToken = registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self] (cell: UITableViewCell, previousTraitCollection: UITraitCollection) in
                if previousTraitCollection.userInterfaceStyle != self?.traitCollection.userInterfaceStyle {
                    if let message = self?.getMessageFromCurrentState() {
                        self?.configure(with: message)
                    }
                }
            }
        }
    }
    
    // 从当前UI状态尝试重建消息对象
    private func getMessageFromCurrentState() -> Message? {
        guard let text = bubbleView.messageLabel.text,
              let _ = timeLabel.text else {
            return nil
        }
        
        // 判断消息类型
        let messageType: MessageType = readStatusView.isHidden ? .received : .sent
        
        // 获取头像
        let avatar: UIImage
        if messageType == .sent {
            avatar = UIImage(named: "zhang-jilong") ?? avatarImageView.image ?? UIImage()
        } else {
            avatar = avatarImageView.image ?? UIImage()
        }
        
        // 创建临时的发送者
        let tempSender = Contact(
            avatar: avatar,
            name: senderNameLabel.text ?? "",
            latestMsg: "",
            datetime: "",
            type: messageType == .sent ? .user : .bot
        )
        
        // 创建临时消息对象
        return Message(
            content: text,
            sender: tempSender,
            type: messageType,
            isRead: readStatusView.image?.description.contains("fill") ?? false
        )
    }
    
    // 辅助方法：移除指定标识符的约束
    private func removeConstraintsWithIdentifier(_ identifier: String) {
        contentView.constraints.forEach { constraint in
            if constraint.identifier == identifier {
                contentView.removeConstraint(constraint)
            }
        }
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
        senderNameLabel.text = nil
        timeLabel.text = nil
        readStatusView.image = nil
        // 重置所有视图的可见性状态
        readStatusView.isHidden = true
        senderNameLabel.isHidden = false
        avatarImageView.isHidden = false
        // 清除气泡视图内容
        bubbleView.configure(text: "", type: .received)
    }
}

//辅助测试的方法
#if DEBUG
extension MessageCell {
    // 安全配置测试消息的方法
    func testHelper_configureSafely(content: String, type: MessageType, isRead: Bool = true) {
        // 创建一个安全的测试用 Contact 对象
        let safeContact = Contact(
            avatar: UIImage(systemName: "person.circle") ?? UIImage(), // 使用系统图标，避免 nil
            name: "测试发送者",
            latestMsg: "",
            datetime: "",
            type: .user
        )
        
        // 使用安全的对象创建 Message
        let safeMessage = Message(
            content: content,
            sender: safeContact,
            type: type,
            isRead: isRead
        )
        
        // 调用实际的配置方法
        self.configure(with: safeMessage)
    }
    
    // 为测试暴露内部视图
    var testHelper_bubbleView: ChatBubbleView {
        return bubbleView
    }
    
    var testHelper_readStatusView: UIImageView {
        return readStatusView
    }
    
    var testHelper_senderNameLabel: UILabel {
        return senderNameLabel
    }
    
    var testHelper_timeLabel: UILabel {
        return timeLabel
    }
    
    var testHelper_avatarImageView: UIImageView {
        return avatarImageView
    }
}
#endif
