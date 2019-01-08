//
//  NextLaunchViewController.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/01.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
//import PKHUD

class NextLaunchViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var mapCanvasView: UIView!
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var remarksTextField: UITextView!
    
    var selectedEvent: Event?
    let marker = GMSMarker()
    var mapView: GMSMapView!
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var placesClient: GMSPlacesClient!
    private var zoomLevel: Float = 15.0
    let defaultLatitude = 35.690017 //新宿駅
    let defaultLongitude = 139.700363  //新宿駅
    /// 初期描画の判断に利用
    private var initView: Bool = false
    
    var didChangedImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.marker.position.latitude = self.defaultLatitude
        self.marker.position.longitude = self.defaultLongitude
        
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: zoomLevel)
        let rect = CGRect(x: 0, y: 0, width: view.bounds.width, height: mapCanvasView.bounds.height)
        self.mapView = GMSMapView.map(withFrame: rect, camera: camera)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.view.addGestureRecognizer(tapRecognizer)
        
        // GoogleMapの初期化
        // 自分の場所を中心に合わせるボタン
        self.mapView?.settings.myLocationButton = true
        self.mapView?.mapType = GMSMapViewType.normal
        self.mapView?.settings.compassButton = true
        // 自分の場所を表示する
        self.mapView?.isMyLocationEnabled = true
        self.mapView?.delegate = self
        
        mapCanvasView.addSubview(self.mapView!)
        
        // 位置情報関連の初期化
        // 自分の場所を取得
//        self.locationManager = CLLocationManager()
        // 更新頻度や精度で消費電力がかわってくる
        // 位置情報の更新をどれ位一時停止出来るかを判断 自動車用、歩行者用等など
        self.locationManager?.activityType = .other
        // 精度
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager?.requestAlwaysAuthorization()
        // 更新イベントの生成に必要な、水平方向の最小移動距離（メートル単位）
        self.locationManager?.distanceFilter = 50
        // 開始
        self.locationManager?.startUpdatingLocation()
        self.locationManager?.delegate = self
        
        self.placesClient = GMSPlacesClient.shared()
        self.marker.map = self.mapView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// マーカー以外をタップしたら
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.marker.position = coordinate
    }
    
    // MARK: CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !self.initView {
            // 初期描画時のマップ中心位置の移動
            let camera = GMSCameraPosition.camera(withTarget: (locations.last?.coordinate)!, zoom: self.zoomLevel)
            self.mapView.camera = camera
            self.locationManager?.stopUpdatingLocation()
            self.initView = true
        }
    }
    
    //画面をタップすると、キーボードが閉じる動作
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        remarksTextField.resignFirstResponder()
    }
    
    @IBAction func checkButton(_ sender: Any) {
        
        let latitude = self.marker.position.latitude
        let longitude = self.marker.position.longitude
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
        
//        let imageUrl:String? = todoImageView?.image
//        UserDefaults.standard.set(imageUrl, forKey: "imageUrl")
//        if (didChangedImage) {
//            taskService.saveImage(image: todoImageView.image) { (imagleteUrl) in
//                targetTask.imageUrl = imagleteUrl
//                self.taskService.save()
//                self.didChangedImage = false
//                HUD.hide()
//                self.navigationController?.popViewController(animated: true)
//            }
//        } else {
//            self.taskService.save()
//            self.didChangedImage = false
//            self.navigationController?.popViewController(animated: true)
//        }
        
        let remarks = remarksTextField.text
        UserDefaults.standard.set(remarks, forKey: "remarks")
        
        print("緯度", latitude)
        print("経度", longitude)
//        print("写真", imageUrl!)
        print("備考", remarks!)
    }
    
    @IBAction func didTouchImageButton(_ sender: Any) {
        let alert = UIAlertController(title:"", message: "選択してください", preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction(title: "カメラ", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("カメラ")
            self.presentPicker(SourceType: .camera)
            
        }))
        alert.addAction(UIAlertAction(title: "アルバム", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            print("アルバム")
            self.presentPicker(SourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセル")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentPicker(SourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(SourceType){
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = SourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }else {
            print("The sourceType is not available")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            todoImageView.contentMode = .scaleAspectFill
            todoImageView.image = pickedImage.resize(size: CGSize(width: 300, height: 200))
            didChangedImage = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
