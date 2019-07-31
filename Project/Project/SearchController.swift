import UIKit
import CoreML
import Vision

class SearchController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var cameraButton: UIButton!
  @IBOutlet var photoLibraryButton: UIButton!
  @IBOutlet var resultsView: UIView!
  @IBOutlet var resultsLabel: UILabel!

    @IBOutlet var categoryResultLabel: UILabel!
    @IBOutlet var patternResultLabel: UILabel!
    @IBOutlet var fabricResultLabel: UILabel!
    @IBOutlet var resultsConstraint: NSLayoutConstraint!

  var firstTime = true

    lazy var categoryClassificationRequest: VNCoreMLRequest = {
        do {
            let categoryClassifier = CategoryClassifier()
//            let visionModel = try VNCoreMLModel(for: healthySnacks.model)
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
//                    self.resultsLabel.text = "nothing found"
                    self.categoryResultLabel.text = "nothing found"
                } else if results[0].confidence < 0.2 {
 //                   self.resultsLabel.text = "not sure"
                    self.categoryResultLabel.text = "not sure"
                } else {
//                    self.resultsLabel.text = String(format: "%@ %.1f%%",
 //                                                   results[0].identifier,
 //                                                   results[0].confidence * 100)
                    self.categoryResultLabel.text = String(format: "%@ %.1f%%",
                                                    results[0].identifier,
                                                    results[0].confidence * 100)
                }
            } else if  let error = error {
//                self.resultsLabel.text = "error: \(error.localizedDescription)"
                self.categoryResultLabel.text = "error: \(error.localizedDescription)"
            } else {
 //               self.resultsLabel.text = "???"
                self.categoryResultLabel.text = "???"
            }
//            self.showResultsView()
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
                }
            } else if  let error = error {
                self.patternResultLabel.text = "error: \(error.localizedDescription)"
            } else {
                self.patternResultLabel.text = "???"
            }
            //            self.showResultsView()
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
                }
            } else if  let error = error {
                self.fabricResultLabel.text = "error: \(error.localizedDescription)"
            } else {
                self.fabricResultLabel.text = "???"
            }
            //            self.showResultsView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let picker = UIImagePickerController()
        resultsView.alpha = 0
        resultsLabel.text = "choose or take a photo"
//        categoryResultLabel.text = "category : "
//        patternResultLabel.text = "waiting for Pattern Result..."
//        fabricResultLabel.text = "loading......."
        picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Show the "choose or take a photo" hint when the app is opened.
    if firstTime {
//      showResultsView(delay: 0.5)
      firstTime = false
    }
  }
  
  @IBAction func takePicture() {
    presentPhotoPicker(sourceType: .camera)
  }

  @IBAction func choosePhoto() {
    presentPhotoPicker(sourceType: .photoLibrary)
  }

  func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
    let picker = UIImagePickerController()
    picker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
    picker.sourceType = sourceType
    present(picker, animated: true)
//    hideResultsView()
  }

  func showResultsView(delay: TimeInterval = 0.1) {
    resultsConstraint.constant = 100
    view.layoutIfNeeded()

    UIView.animate(withDuration: 0.5,
                   delay: delay,
                   usingSpringWithDamping: 0.6,
                   initialSpringVelocity: 0.6,
                   options: .beginFromCurrentState,
                   animations: {
      self.resultsView.alpha = 1
      self.resultsConstraint.constant = -10
      self.view.layoutIfNeeded()
    },
    completion: nil)
  }

  func hideResultsView() {
    UIView.animate(withDuration: 0.3) {
      self.resultsView.alpha = 0
    }
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
            print("Failed to perform classification: \(error)")
        }
    }
  }
}

extension searchController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
    let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

    picker.dismiss(animated: true)

    let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as! UIImage
    imageView.image = image

    classify(image: image)
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
