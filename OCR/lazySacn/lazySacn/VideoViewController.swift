import UIKit
import AVFoundation
import TesseractOCR

class VideoViewController: UIViewController{
    let cameraController = CameraController()
    @IBOutlet weak var capturePreviewView: UIView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var ocrImage: UIImageView!
    @IBOutlet weak var ocrOutput: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timelabel2: UILabel!
    
    @IBAction func captureImage(_ sender: UIButton) {
        cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            let start = CFAbsoluteTimeGetCurrent()
            
            self.ocrImage.image = image
            
            let imageData = image.pngData()
            let pngImage = UIImage(data: imageData!)
            
            let rotateImage = pngImage!.imageRotated(on: 90)
             print("image size: \(rotateImage.size.width) x \(rotateImage.size.height)")
            
            //let reziedImage = rotateImage.resize(toTargetSize: CGSize(width: rotateImage.size.width/2, height: rotateImage.size.height/10))
           
            let reziedImage = rotateImage.cropToBounds(image: rotateImage, width: Double(rotateImage.size.width), height: Double(rotateImage.size.height/2.25))
           
            print("image size: \(reziedImage.size.width) x \(reziedImage.size.height)")
           
            var diff = CFAbsoluteTimeGetCurrent() - start
            self.timelabel2.text = "Image \(diff) s"
            
            
            self.ocr(image: reziedImage)
            DispatchQueue.main.async {
                self.ocrImage.image = reziedImage
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                }
                
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        }
        configureCameraController()
    }
    
    func ocr(image: UIImage?){
        let start = CFAbsoluteTimeGetCurrent()
        if let image = image{
            if let tesseract = G8Tesseract(language: "eng") {
                // 2
                tesseract.engineMode = .tesseractCubeCombined
                // 3
                tesseract.pageSegmentationMode = .auto
                // 4
                tesseract.image = image
                // 5
                tesseract.recognize()
                // 6
                
                ocrOutput.text = tesseract.recognizedText
                print("finish")
                print(tesseract)
                print(tesseract.recognizedText as Any)
                
            }
            
            var diff = CFAbsoluteTimeGetCurrent() - start
            timeLabel.text = "OCR \(diff) s"
            print("Took \(diff) seconds")
        }
        
    }
    

}



