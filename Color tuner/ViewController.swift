//  Color tuner: Mickey mouse
//
import UIKit

class ViewController: UIViewController {

    // 設置元件 UIView (名為 clothesView)，並以 IBOutlet 連結到圖檔 clothesView (當作遮罩)
    @IBOutlet weak var clothesView: UIView!
    
    // 設置元件 UIImageView (名為 MickeyImageView)，並以 IBOutlet 連結到圖檔 MickeyImageView (當作底圖)
    @IBOutlet weak var MickeyImageView: UIImageView!
    
    // 設置元件 UIView (名為 gradientView)，並以 IBOutlet 連結到圖檔 clothesView (當作漸層)
    @IBOutlet var gradientView: UIView! // 為了搭配 gradientView.removeFromSuperview() ，在漸層後也可繼續使用其它的 slider 調色 (將漸層效果移除)，所以這裡要把 "weak" 四個字母刪掉
    
    
    // 設置元件 UISlider (R / G / B / Alpha) ，並以 IBOutlet 連結至程式中的變數 redSlider ，用以對應各個 Slider
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
            
    // 漸層效果要另外拉 IBOutlet 連結所對應的圖面部位的 UIView，例：口袋 或 身體
    // 設置元件 UISlider (gradientSlider) ，並以 IBOutlet 連結至程式中的變數 gradientSlider ，用以對應關係
    @IBOutlet var gradientSlider: UISlider!
    
    
    // 設置元件 UILabel 並以 IBOutlet 連結至程式中的 redSliderValueDisplay ，用以顯示 redSlider 的數值
    @IBOutlet weak var redSliderValueDisplay: UILabel!
    @IBOutlet weak var greenSliderValueDisplay: UILabel!
    @IBOutlet weak var blueSliderValueDisplay: UILabel!
    @IBOutlet weak var alphaSliderValueDisplay: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
         
        let clothesImageView = UIImageView(image: UIImage(named: "clothes")) // 宣告一個名為 clothesImageView 的常數，並存入名為 clothes 的圖檔
        clothesImageView.frame = clothesView.bounds // 將 clothesImageView (UIImageView) 的框架尺寸調整成跟 clothesView (UIView 的 IBOutlet) 一樣
        clothesImageView.contentMode = .scaleAspectFit // 設定 clothesImageView (UIImageView) 的顯示模式為 Aspect fit
        clothesView.mask = clothesImageView // 使用 clothesImageView (UIImageView) 當作 clothesView (UIView 的 IBOutlet) 的遮罩
        clothesView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1) // 預設啟動時衣服顏色為紅色
        
        
        // 宣告一個名為 MickeyImageView 的常數，並存入名為 Mickey 的圖檔作為底圖，並確認 MickeyImageView (UIImageView) 跟 clothesView 的框架尺寸調整成一樣
        let MickeyImageView = UIImageView(image: UIImage(named: "Mickey"))
        MickeyImageView.frame = clothesView.bounds // 將 MickeyImageView (UIImageView) 的框架尺寸調整成跟 clothesView (UIView 的 IBOutlet) 一樣
        MickeyImageView.contentMode = .scaleAspectFit // 設定 MickeyImageView (UIImageView) 的顯示模式為 Aspect fit
        
        gradientView.frame = clothesView.bounds // 將 gradientView (UIImageView) 的框架尺寸調整成跟 clothesView (UIView 的 IBOutlet) 一樣
        
        
    }
    
    // 宣告一個名為 changingColorSlidder 的 IBAction function ，用以設定 UIImageView 的背景顏色隨 UISlidder 的動作改變
    // 連結 IBoutlet 的 UIView (clothesView) 到所有的 slider ，才可以順利反應 slider 的動作到 clothesView
    @IBAction func changingColorSlidder(_ sender: UISlider) {
        gradientView.removeFromSuperview() // 將漸層效果移除
        clothesView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
            }
    
    // 宣告一個名為 gradientSlider 的 IBAction function ，用以設定漸層效果
    @IBAction func gradientSlider(_ sender: UISlider) {
    
        let gradientLayer = CAGradientLayer() // 宣告一個常數，用以設定漸層效果的圖層
        gradientLayer.frame = gradientView.bounds //設定漸層效果的圖層框架要與 gradientView 一致
        gradientLayer.frame = clothesView.bounds //設定漸層效果的圖層框架要與 clothesView 一致

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) //設定漸層效果的圖層框架起啟點
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0) //設定漸層效果的圖層框架終點
        gradientLayer.locations = [0.0, NSNumber(value: gradientSlider.value)] //設定漸層效果的圖層顯示位置要隨 gradientSlider 變化
        gradientLayer.colors = [CGColor(srgbRed: 55/255, green: 55/255, blue: 133/255, alpha: 0.1), CGColor(srgbRed: 255/255, green: 228/255, blue: 225/255, alpha: 1)] //設定漸層效果的圖層顏色

        gradientView.layer.addSublayer(gradientLayer)
        clothesView.addSubview(gradientView)


    }
    
    
    // 宣告一個名為 changedSliderValue 的 IBAction function ，將各個 slider 的數值顯示在 IBOutlet redSliderValueDisplay (UILabel) 上
    @IBAction func changedSliderValue(_ sender: UISlider) {
        redSliderValueDisplay.text = String(format: "%.2f", redSlider.value)
        greenSliderValueDisplay.text = String(format: "%.2f", greenSlider.value)
        blueSliderValueDisplay.text = String(format: "%.2f", blueSlider.value)
        alphaSliderValueDisplay.text = String(format: "%.2f", alphaSlider.value)
        }
    
    // 設置一個 隨機選擇顏色的按鈕，以改變衣服的顏色
    @IBAction func randomize(_ sender: UIButton) {
        gradientView.removeFromSuperview() // 將漸層效果移除
        redSlider.value = Float.random(in: 0...0.5) // 因為 Mickey 原本就是穿紅色，所以故意讓紅色衣服不出現，才會有隨機選色的新鮮感
        greenSlider.value = Float.random(in: 0...1)
        blueSlider.value = Float.random(in: 0...1)
        alphaSlider.value = 1 // 故意設成不透明，才不會讓底圖的紅衣一直跑出來

        clothesView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaSlider.value))
        
        
        // 串連 IBOutlet 以顯示 slider 值
        redSliderValueDisplay.text = String(format: "%.1f", redSlider.value)
        greenSliderValueDisplay.text = String(format: "%.1f", greenSlider.value)
        blueSliderValueDisplay.text = String(format: "%.1f", blueSlider.value)
        alphaSliderValueDisplay.text = String(format: "%.1f", alphaSlider.value)
        

        
    }
    
    
    }
    
    
    
    
    
    
    

        
  
        
        
    
    
    

