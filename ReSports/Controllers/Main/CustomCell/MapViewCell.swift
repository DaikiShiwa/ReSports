//
//  MapViewCell.swift
//  ReSports
//
//  Created by 志波大輝 on 2019/01/09.
//  Copyright © 2019 志波大輝. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewCell:UITableViewCell, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapPinImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapViewCanvas: UIView!
    
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
    
    func viewDidLoad() {

        self.marker.position.latitude = self.defaultLatitude
        self.marker.position.longitude = self.defaultLongitude
        
        let camera = GMSCameraPosition.camera(withTarget: marker.position, zoom: zoomLevel)
        let rect = CGRect(x: 0, y: 0, width: mapViewCanvas.bounds.width, height: mapViewCanvas.bounds.height)
        self.mapView = GMSMapView.map(withFrame: rect, camera: camera)
        
        // GoogleMapの初期化
        // 自分の場所を中心に合わせるボタン
        self.mapView?.settings.myLocationButton = true
        self.mapView?.mapType = GMSMapViewType.normal
        self.mapView?.settings.compassButton = true
        // 自分の場所を表示する
        self.mapView?.isMyLocationEnabled = true
        self.mapView?.delegate = self
        
        mapViewCanvas.addSubview(self.mapView!)
        
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
    
}


