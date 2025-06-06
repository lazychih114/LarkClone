//
//  LarkColor.swift
//  Lark-Clone
//
//  Created by 张纪龙 on 2025/4/28.
//

import UIKit

// 这个类将只在 Swift 代码中使用
public class LarkColorStyle: NSObject {
    
    // MARK: - Email Cell 相关颜色
    public class EmailCell: NSObject {
        // 未读指示器颜色
        public class var unreadIndicatorColor: UIColor {
            return UIColor.systemBlue
        }
        
        // 背景色
        public class var backgroundColor: UIColor {
            return UIColor.systemBackground
        }
        
        // 未读邮件背景色
        public class var unreadBackgroundColor: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1.0)
                    : UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1.0)
            }
        }
        
        // 发件人标签颜色
        public class var senderLabelColor: UIColor {
            return UIColor.label
        }
        
        // 日期标签颜色
        public class var dateLabelColor: UIColor {
            return UIColor.secondaryLabel
        }
        
        // 主题标签颜色
        public class var subjectLabelColor: UIColor {
            return UIColor.label
        }
        
        // 预览标签颜色
        public class var previewLabelColor: UIColor {
            return UIColor.secondaryLabel
        }
        
        // 附件图标颜色
        public class var attachmentIconColor: UIColor {
            return UIColor.secondaryLabel
        }
    }
    
    // MARK: - 通用界面颜色
    public struct UI {
        // 通用背景色
        public static var backgroundColor: UIColor {
            return UIColor.systemBackground
        }
        
        // 表格视图背景色
        public static var tableViewBackgroundColor: UIColor {
            return UIColor.systemBackground
        }
        
        // 轻微灰色背景 (alpha 0.96)
        public static var lightGrayBackground: UIColor {
            return UIColor(white: 0.96, alpha: 1.0)
        }
        
        // 边框颜色 (alpha 0.3)
        public static var borderColor: UIColor {
            return UIColor.lightGray.withAlphaComponent(0.3)
        }
        
        // 轻微边框颜色 (alpha 0.5)
        public static var lightBorderColor: UIColor {
            return UIColor.lightGray.withAlphaComponent(0.5)
        }
        
        // 空标签颜色
        public static var emptyLabelColor: UIColor {
            return UIColor.secondaryLabel
        }
    }
    
    // MARK: - TabBar相关颜色
    public struct TabBar {
        // 标签栏暗色背景
        public static var darkBackground: UIColor {
            return UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        }
        
        // 标签栏色调
        public static var tintColor: UIColor {
            return UIColor.systemBlue
        }
    }
    
    // MARK: - 其它颜色
    // 标签颜色
    public struct Tag {
        // 机器人标签
        public struct Bot {
            public static var textColor: UIColor {
                return UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark
                        ? UIColor(red: 200/255.0, green: 150/255.0, blue: 30/255.0, alpha: 1)
                        : UIColor(red: 172/255.0, green: 123/255.0, blue: 3/255.0, alpha: 1)
                }
            }
            
            public static var backgroundColor: UIColor {
                return UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark
                        ? UIColor(red: 60/255.0, green: 50/255.0, blue: 10/255.0, alpha: 1)
                        : UIColor(red: 253/255.0, green: 246/255.0, blue: 220/255.0, alpha: 1)
                }
            }
        }
        
        // 外部联系人标签
        public struct External {
            public static var textColor: UIColor {
                return UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark
                        ? UIColor(red: 100/255.0, green: 140/255.0, blue: 255/255.0, alpha: 1)
                        : UIColor(red: 17/255.0, green: 72/255.0, blue: 219/255.0, alpha: 1)
                }
            }
            
            public static var backgroundColor: UIColor {
                return UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark
                        ? UIColor(red: 30/255.0, green: 40/255.0, blue: 80/255.0, alpha: 1)
                        : UIColor(red: 209/255.0, green: 221/255.0, blue: 253/255.0, alpha: 1)
                }
            }
        }
    }
    
    // 文本颜色
    public struct Text {
        public static var primary: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor.white
                    : UIColor.black
            }
        }
        
        public static var secondary: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor.lightGray
                    : UIColor.systemGray
            }
        }
    }
   
    // 聊天气泡颜色
    public struct ChatBubble {
        // 发送者(自己)气泡
        public struct Sent {
            public static var backgroundColor: UIColor {
                return UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark
                        ? UIColor(red: 0.0, green: 0.47, blue: 0.99, alpha: 1.0) // 更鲜亮的蓝色
                        : UIColor(red: 0.0, green: 0.47, blue: 0.99, alpha: 1.0) // 苹果风格蓝色
                }
            }
            
            public static var textColor: UIColor {
                return UIColor.white // 始终使用白色文本
            }
        }
        
        // 接收者气泡
        public struct Received {
            public static var backgroundColor: UIColor {
                return UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark
                        ? UIColor(red: 0.28, green: 0.28, blue: 0.3, alpha: 1.0) // 更亮的深灰色
                        : UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0) // 浅灰色
                }
            }
            
            public static var textColor: UIColor {
                return UIColor { traitCollection in
                    return traitCollection.userInterfaceStyle == .dark
                        ? UIColor.white
                        : UIColor.black
                }
            }
        }
    }
   
    // 已读状态标记颜色
    public struct ReadStatus {
        public static var tintColor: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor(red: 76/255.0, green: 217/255.0, blue: 100/255.0, alpha: 1.0) // 亮绿色
                    : UIColor(red: 52/255.0, green: 199/255.0, blue: 89/255.0, alpha: 1.0) // 苹果风格绿色
            }
        }
    }
    
    // 头像背景颜色
    public struct Avatar {
        public static var backgroundColor: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor(red: 0.3, green: 0.3, blue: 0.32, alpha: 1.0) // 深色模式下稍亮的灰色
                    : UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.0) // 浅色模式下的浅灰色
            }
        }
        
        // AvatarUtility使用的颜色
        public static var systemGray4: UIColor {
            return UIColor.systemGray4
        }
    }
    
    // MARK: - 聊天界面相关颜色
    public struct Chat {
        // 背景色
        public static var backgroundColor: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor.black
                    : UIColor.white
            }
        }
        
        // 输入容器背景色
        public static var inputContainerColor: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
                    : UIColor.white
            }
        }
        
        // 输入框背景色
        public static var inputFieldColor: UIColor {
            return UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark
                    ? UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
                    : UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0) // 更浅的灰色背景
            }
        }
    }
}
