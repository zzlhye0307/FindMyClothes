import UIKit
import CoreML
import Vision
import CoreData

class ViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cameraButton: UIButton!
  @IBOutlet var photoLibraryButton: UIButton!

    @IBOutlet var categoryResultLabel: UILabel!
    @IBOutlet var patternResultLabel: UILabel!
    @IBOutlet var fabricResultLabel: UILabel!
    
    @IBOutlet var categoryEtcLabel: UILabel!
    @IBOutlet var patternEtcLabel: UILabel!
    @IBOutlet var fabricEtcLabel: UILabel!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var sgIndexLabel: UILabel!
    @IBOutlet var categoryRenewSgButton: UISegmentedControl!
    @IBOutlet var fabricRenewSgButton: UISegmentedControl!
    @IBOutlet var patternRenewSgButton: UISegmentedControl!
    
    let originalMode = true
    let searchMode = false
    var predictedCategory: String?
    var predictedPattern: String?
    var predictedFabric: String?
    var category: String?
    var pattern: String?
    var fabric: String?
    var selectedImg: UIImage?
    var selectedImgType: String?
    var isMoved = false
    
    lazy var categoryClassificationRequest: VNCoreMLRequest = {
        do {
            let categoryClassifier = CategoryClassifier()
            let visionModel = try VNCoreMLModel(for: categoryClassifier.model)
            let request = VNCoreMLRequest(model: visionModel,
                                          completionHandler: {
                                            [weak self] request, error in
                                            self?.processCategoryObservations(for: request, error: error)
            })
            request.imageCropAndScaleOption = .scaleFit
            return request
        }catch {
            fatalError("Failed to create VNCoreMLModel:  \(error)")
        }
    }()
    
    func processCategoryObservations(for request: VNRequest, error: Error?){
        DispatchQueue.main.async {
            if let results = request.results as? [VNClassificationObservation] {
                if results.isEmpty {
                    self.categoryResultLabel.text = "nothing found"
                } else if results[0].confidence < 0.2 {
                    self.categoryResultLabel.text = "not sure"
                } else {
                    self.categoryResultLabel.text = String(format: "%@ %.1f%%",
                                                    results[0].identifier,
                                                    results[0].confidence * 100)
                    self.predictedCategory = results[0].identifier
                    self.category = self.predictedCategory
                    for i in 1 ..< results.count {
                        self.categoryRenewSgButton.setTitle(results[i].identifier, forSegmentAt: i)
                    }
                }
            } else if  let error = error {
                self.categoryResultLabel.text = "error: \(error.localizedDescription)"
            } else {
                self.categoryResultLabel.text = "???"
            }
        }
    }

    lazy var patternClassificationRequest: VNCoreMLRequest = {
        do {
            let patternClassifier = PatternClassifier3()
            let visionModel = try VNCoreMLModel(for: patternClassifier.model)
            let request = VNCoreMLRequest(model: visionModel,
                                          completionHandler: {
                                            [weak self] request, error in
                                            self?.processPatternObservations(for: request, error: error)
            })
            request.imageCropAndScaleOption = .scaleFit
            return request
        }catch {
            fatalError("Failed to create VNCoreMLModel:  \(error)")
        }
    }()
    
    func processPatternObservations(for request: VNRequest, error: Error?){
        DispatchQueue.main.async {
            if let results = request.results as? [VNClassificationObservation] {
                if results.isEmpty {
                    self.patternResultLabel.text = "nothing found"
                } else if results[0].confidence < 0.2 {
                    self.patternResultLabel.text = "not sure"
                } else {
                    self.patternResultLabel.text = String(format: "%@ %.1f%%",
                                                          results[0].identifier,
                                                          results[0].confidence * 100)
                    self.predictedPattern = results[0].identifier
                    self.pattern = self.predictedPattern
                    for i in 1 ..< results.count {
                        self.patternRenewSgButton.setTitle(results[i].identifier, forSegmentAt: i)
                    }
                }
            } else if  let error = error {
                self.patternResultLabel.text = "error: \(error.localizedDescription)"
            } else {
                self.patternResultLabel.text = "???"
            }
        }
    }

    lazy var fabricClassificationRequest: VNCoreMLRequest = {
        do {
            let fabricClassifier = FabricClassifier()
            let visionModel = try VNCoreMLModel(for: fabricClassifier.model)
            let request = VNCoreMLRequest(model: visionModel,
                                          completionHandler: {
                                            [weak self] request, error in
                                            self?.processFabricObservations(for: request, error: error)
            })
            request.imageCropAndScaleOption = .scaleFit
            return request
        }catch {
            fatalError("Failed to create VNCoreMLModel:  \(error)")
        }
    }()
    
    func processFabricObservations(for request: VNRequest, error: Error?){
        DispatchQueue.main.async {
            if let results = request.results as? [VNClassificationObservation] {
                if results.isEmpty {
                    self.fabricResultLabel.text = "nothing found"
                } else if results[0].confidence < 0.2 {
                    self.fabricResultLabel.text = "not sure"
                } else {
                    self.fabricResultLabel.text = String(format: "%@ %.1f%%",
                                                          results[0].identifier,
                                                          results[0].confidence * 100)
                    self.predictedFabric = results[0].identifier
                    self.fabric = self.predictedFabric
                    for i in 1 ..< results.count {
                        self.fabricRenewSgButton.setTitle(results[i].identifier, forSegmentAt: i)
                    }
                }
            } else if  let error = error {
                self.fabricResultLabel.text = "error: \(error.localizedDescription)"
            } else {
                self.fabricResultLabel.text = "???"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = UIImagePickerController()
        picker.delegate = self
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  @IBAction func takePicture() {
    presentPhotoPicker(sourceType: .camera)
    returnSgIndexToOriginalState()
  }

  @IBAction func choosePhoto() {
    presentPhotoPicker(sourceType: .photoLibrary)
    returnSgIndexToOriginalState()
  }

  func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.sourceType = sourceType
    present(picker, animated: true)
  }
    
    func returnSgIndexToOriginalState() {
        categoryRenewSgButton.selectedSegmentIndex = 0
        patternRenewSgButton.selectedSegmentIndex = 0
        fabricRenewSgButton.selectedSegmentIndex = 0
    }

    func classify(image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            print("Unable to create CIImage")
            return
        }
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
        
            do{
                try handler.perform([self.categoryClassificationRequest, self.patternClassificationRequest, self.fabricClassificationRequest])
//            try handler.perform([self.patternClassificationRequest])
 //           try handler.perform([self.fabricClassificationRequest])
            }catch {
//                let message = "category : " + category +
//                    "\npattern : " + pattern + "\nfabric : " + fabric + "이 결과가 맞습니까?"
                let message = "Hello"
                let failAlarm = UIAlertController(title: "확인", message: message, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
                let noAction = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: nil)
                failAlarm.addAction(okAction)
                failAlarm.addAction(noAction)
                self.present(failAlarm, animated: true, completion: nil)
                print("Failed to perform classification: \(error)")
            }
        }
    }
    
    func changeBtnState(_ mode: Bool) {
        cameraButton.isHidden = !mode
        photoLibraryButton.isHidden = !mode
        descriptionLabel.isHidden = !mode
        categoryEtcLabel.isHidden = mode
        patternEtcLabel.isHidden = mode
        fabricEtcLabel.isHidden = mode
        changeButton.isHidden = mode
        searchButton.isHidden = mode
        categoryRenewSgButton.isHidden = mode
        patternRenewSgButton.isHidden = mode
        fabricRenewSgButton.isHidden = mode
        sgIndexLabel.isHidden = mode
    }
    
    @IBAction func sgChangeCategory(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex != 0) {
            category = sender.titleForSegment(at: sender.selectedSegmentIndex)
        }
        else {
            category = predictedCategory
        }
    }
    
    @IBAction func sgChangePattern(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex != 0) {
            pattern = sender.titleForSegment(at: sender.selectedSegmentIndex)
        }
        else {
            pattern = predictedPattern
        }
    }
    
    @IBAction func sgChangeFabric(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex != 0) {
            fabric = sender.titleForSegment(at: sender.selectedSegmentIndex)
        }
        else {
            fabric = predictedFabric
        }
    }
    
    @IBAction func goBackBtn(_ sender: UIButton) {
        changeBtnState(originalMode)
    }
    
    @IBAction func search(_ sender: UIButton) {
        if category == nil || pattern == nil || fabric == nil {
            let waitAlert = UIAlertController(title: "경고", message: "이미지 분석 중 입니다.\n잠시만 기다려 주세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            waitAlert.addAction(okAction)
            present(waitAlert, animated: true, completion: nil)
            changeBtnState(searchMode)
        }
        else {
            let categoryMessage = "category : " + category! + "\n"
            let patternMessage = "pattern : " + pattern! + "\n"
            let fabricMessage = "fabric : " + fabric! + "\n"
            let message = categoryMessage + patternMessage + fabricMessage
            let confirmAlarm = UIAlertController(title: "이 결과대로 진행하시겠습니까?", message: message, preferredStyle:   UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "네", style: UIAlertAction.Style.default, handler: {
                ACTION in
                self.isMoved = true
                let resultView = self.storyboard?.instantiateViewController(withIdentifier: "searchResultView")
                resultView?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            
                self.present(resultView!, animated: true, completion: nil)
                self.changeBtnState(self.searchMode)
                self.insertLog()
            })
            let noAction = UIAlertAction(title: "아니요", style: UIAlertAction.Style.default, handler: {
                ACTION in
                self.isMoved = false
                self.changeBtnState(self.searchMode)
                self.dismiss(animated: true, completion: nil)
            })
            confirmAlarm.addAction(okAction)
            confirmAlarm.addAction(noAction)
            self.present(confirmAlarm, animated: true, completion: nil)
        }
    }
    
    func insertLog() {
        var imgData: NSData?
        let date: Date = Date()
        
        if selectedImgType == "JPG" {
            imgData = selectedImg?.jpegData(compressionQuality: 1.0) as! NSData
        }
        else if selectedImgType == "PNG" {
            imgData = selectedImg?.pngData() as! NSData
        }
        else {
            print("Can't recognize the type of image. Sorry")
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let logEntity = NSEntityDescription.entity(forEntityName: "Log", in: managedContext)!
        let newLog = NSManagedObject(entity: logEntity, insertInto: managedContext)
        newLog.setValue(imgData!, forKey: "img")
        newLog.setValue(category, forKey: "category")
        newLog.setValue(pattern, forKey: "pattern")
        newLog.setValue(fabric, forKey: "fabric")
        newLog.setValue(date, forKey: "date")
        managedContext.insert(newLog)
        do {
            managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            try managedContext.save()
        } catch let error as NSError {
            print("error: \(error)")
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

    picker.dismiss(animated: true)

    let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
    imageView.image = image
    selectedImg = image
    let imgURL = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.imageURL)] as! NSURL
    if (imgURL.absoluteString?.hasSuffix(".jpg"))! || (imgURL.absoluteString?.hasSuffix(".jpeg"))! {
        selectedImgType = "JPG"
    }
    else if (imgURL.absoluteString?.hasSuffix(".png"))! {
        selectedImgType = "PNG"
    }
    else {
        selectedImgType = "UNKNOWN"
    }
    
    classify(image: image)
    changeBtnState(searchMode)
  }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
