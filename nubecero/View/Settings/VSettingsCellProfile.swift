import UIKit
import FirebaseAuth

class VSettingsCellProfile:VSettingsCell
{
    weak var userName:UILabel!
    weak var imageView:UIImageView!
    private weak var layoutImageViewLeft:NSLayoutConstraint!
    private let kUserNameBottom:CGFloat = 30
    private let kUserNameHeight:CGFloat = 40
    private let kImageViewHeight:CGFloat = 100
    
    override init(frame:CGRect)
    {
        super.init(frame:frame)
        isUserInteractionEnabled = false
        
        let userName:UILabel = UILabel()
        userName.isUserInteractionEnabled = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.backgroundColor = UIColor.clear
        userName.font = UIFont.regular(size:14)
        userName.textColor = UIColor.black
        userName.textAlignment = NSTextAlignment.center
        userName.text = NSLocalizedString("VSettingsCellProfile_defaultUserName", comment:"")
        self.userName = userName
        
        let imageView:UIImageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.layer.cornerRadius = kImageViewHeight / 2.0
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.image = #imageLiteral(resourceName: "assetLoader0")
        self.imageView = imageView
        
        addSubview(userName)
        addSubview(imageView)
        
        let views:[String:UIView] = [
            "userName":userName,
            "imageView":imageView]
        
        let metrics:[String:CGFloat] = [
            "userNameBottom":kUserNameBottom,
            "userNameHeight":kUserNameHeight,
            "imageViewHeight":kImageViewHeight]
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:|-0-[userName]-0-|",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:"H:[imageView(imageViewHeight)]",
            options:[],
            metrics:metrics,
            views:views))
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat:
            "V:[imageView(imageViewHeight)]-0-[userName(userNameHeight)]-(userNameBottom)-|",
            options:[],
            metrics:metrics,
            views:views))
        
        layoutImageViewLeft = NSLayoutConstraint(
            item:imageView,
            attribute:NSLayoutAttribute.left,
            relatedBy:NSLayoutRelation.equal,
            toItem:self,
            attribute:NSLayoutAttribute.left,
            multiplier:1,
            constant:0)
        
        addConstraint(layoutImageViewLeft)
        
        loadProfile()
    }
    
    required init?(coder:NSCoder)
    {
        fatalError()
    }
    
    override func layoutSubviews()
    {
        let width:CGFloat = bounds.maxX
        let remain:CGFloat = width - kImageViewHeight
        let margin:CGFloat = remain / 2.0
        layoutImageViewLeft.constant = margin
            
        super.layoutSubviews()
    }
    
    //MARK: private
    
    private func loadProfile()
    {
        guard
        
            let firebaseUser:FIRUser = FIRAuth.auth()?.currentUser
        
        else
        {
            return
        }
        
        userName.text = firebaseUser.displayName
        
        guard
            
            let pictureUrl:URL = firebaseUser.photoURL
        
        else
        {
            return
        }
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        {
            let dataTask:URLSessionDataTask = URLSession.shared.dataTask(
                with:pictureUrl)
            { (data, response, error) in
                
                guard
                    
                    let imageData:Data = data
                    
                else
                {
                    return
                }
                
                let image:UIImage? = UIImage(data:imageData)
                
                DispatchQueue.main.async
                { [weak self] in
                    
                    self?.imageView.image = image
                }
            }
            
            dataTask.resume()
        }
    }
}
