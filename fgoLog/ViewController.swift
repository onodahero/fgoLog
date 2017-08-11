//
//  ViewController.swift
//  fgoLog
//
//  Created by 斧田洋人 on 2017/08/08.
//  Copyright © 2017年 斧田洋人. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource,CellDelegate {
    var questArray: [Quest] = []
    var sozaiArray: [Drop] = []
    var selectedquestArray: [Quest]!
    var areaArray: [String] = ["月曜 弓の修練場", "火曜 槍の修練場", "水曜 狂の修練場", "木曜 騎の修練場", "金曜 術の修練場", "日曜 剣の修練場", "序章 冬木", "1章 オルレアン", "2章 セプテム", "3章 オケアノス", "4章 ロンドン", "5章 イ・ブルーリバス・ウナム", "6章 キャメロット", "7章 バビロニア", "亜種特異点Ⅰ 新宿", "亜種特異点Ⅱ アガルタ"]
    var areaTextField: UITextField!
    var questTextField: UITextField!
    var areaPickerView: UIPickerView!
    var questPickerView: UIPickerView!
    var startButton: UIButton!
    var selectedquest: Quest!
    
    var shuukaiTableView: UITableView!
    var recordButton: UIButton!
    var drop: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 100))
        titleLabel.text = "FGO周回ログ"
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        self.view.addSubview(titleLabel)
        areaTextField = UITextField(frame: CGRect(x:20, y: 100, width: 170, height: 30))
        questTextField = UITextField(frame: CGRect(x: 20, y: 150, width: 170, height: 30))
        areaTextField.delegate = self
        questTextField.delegate = self
        areaTextField.borderStyle = .roundedRect
        questTextField.borderStyle = .roundedRect
        areaTextField.placeholder = "周回場所"
        questTextField.placeholder = "周回場所"
        self.view.addSubview(areaTextField)
        questTextField.isHidden = true
        self.view.addSubview(questTextField)
        let areatoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let areadoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.areadone))
        areatoolbar.setItems([areadoneItem], animated: true)
        let questtoolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let questdoneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(ViewController.questdone))
        questtoolbar.setItems([questdoneItem], animated: true)
        
        startButton = UIButton(frame: CGRect(x: 210, y: 130, width: 80, height: 50))
        startButton.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.5)
        startButton.setTitle("始める", for: .normal)
        startButton.setTitleColor(UIColor.black, for: .normal)
        startButton.addTarget(self, action: #selector(ViewController.start(sender:)), for: .touchUpInside)
        startButton.layer.borderWidth = 1
        startButton.layer.borderColor = UIColor.black.cgColor
        
        areaPickerView = UIPickerView()
        areaPickerView.tag = 1
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        areaPickerView.frame = CGRect(x: 0, y: 450, width: self.view.bounds.width, height: self.view.bounds.height - 450)
        
        questPickerView = UIPickerView()
        questPickerView.tag = 2
        questPickerView.delegate = self
        questPickerView.dataSource = self
        questPickerView.frame = CGRect(x: 0, y: 450, width: self.view.bounds.width, height: self.view.bounds.height - 450)
        
        self.areaTextField.inputView = areaPickerView
        self.questTextField.inputView = questPickerView
        self.areaTextField.inputAccessoryView = areatoolbar
        self.questTextField.inputAccessoryView = questtoolbar
        
        sozaiArray.append(Drop(name: "英雄の証", imagename: "akasi"))
        sozaiArray.append(Drop(name: "狂骨", imagename: "hone"))
        sozaiArray.append(Drop(name: "竜の牙", imagename: "kiba"))
        sozaiArray.append(Drop(name: "虚影の塵", imagename: "tiri"))
        sozaiArray.append(Drop(name: "愚者の鎖", imagename: "kusari"))
        sozaiArray.append(Drop(name: "万死の毒針", imagename: "dokubari"))
        sozaiArray.append(Drop(name: "魔術髄液", imagename: "zuieki"))
        sozaiArray.append(Drop(name: "世界樹の種", imagename: "tane"))
        sozaiArray.append(Drop(name: "ゴーストランタン", imagename: "rantann"))
        sozaiArray.append(Drop(name: "八連双晶", imagename: "hatirenn"))
        sozaiArray.append(Drop(name: "蛇の宝玉", imagename: "hougyoku"))
        sozaiArray.append(Drop(name: "鳳凰の羽根", imagename: "hane"))
        sozaiArray.append(Drop(name: "無間の歯車", imagename: "haguruma"))
        sozaiArray.append(Drop(name: "禁断の頁", imagename: "page"))
        sozaiArray.append(Drop(name: "ホムンクルスベビー", imagename: "baby"))
        sozaiArray.append(Drop(name: "隕蹄鉄", imagename: "hidume"))
        sozaiArray.append(Drop(name: "大騎士勲章", imagename: "kunshou"))
        sozaiArray.append(Drop(name: "追憶の貝殻", imagename: "kaigara"))
        sozaiArray.append(Drop(name: "混沌の爪", imagename: "tume"))
        sozaiArray.append(Drop(name: "蛮神の心臓", imagename: "sinzou"))
        sozaiArray.append(Drop(name: "竜の逆鱗", imagename: "gekirinn"))
        sozaiArray.append(Drop(name: "精霊根", imagename: "reikonn"))
        sozaiArray.append(Drop(name: "戦馬の幼角", imagename: "youkaku"))
        sozaiArray.append(Drop(name: "血の淚石", imagename: "ruiseki"))
        sozaiArray.append(Drop(name: "黒獣脂", imagename: "abura"))
        sozaiArray.append(Drop(name: "封魔のランプ", imagename: "ranpu"))
        sozaiArray.append(Drop(name: "智慧のスカラベ", imagename: "sukarabe"))
        sozaiArray.append(Drop(name: "原初の産毛", imagename: "ubuge"))
        sozaiArray.append(Drop(name: "呪獣胆石", imagename: "tanseki"))
        sozaiArray.append(Drop(name: "弓の輝石", imagename: "yumiki"))
        sozaiArray.append(Drop(name: "弓の魔石", imagename: "yumima"))
        sozaiArray.append(Drop(name: "弓の秘石", imagename: "yumihi"))
        sozaiArray.append(Drop(name: "弓ピース", imagename: "yumipi"))
        sozaiArray.append(Drop(name: "弓モニュメント", imagename: "yumimo"))
        sozaiArray.append(Drop(name: "槍の輝石", imagename: "yariki"))
        sozaiArray.append(Drop(name: "槍の魔石", imagename: "yarima"))
        sozaiArray.append(Drop(name: "槍の秘石", imagename: "yarihi"))
        sozaiArray.append(Drop(name: "槍ピース", imagename: "yaripi"))
        sozaiArray.append(Drop(name: "槍モニュメント", imagename: "yarimo"))
        sozaiArray.append(Drop(name: "狂の輝石", imagename: "kyouki"))
        sozaiArray.append(Drop(name: "狂の魔石", imagename: "kyouma"))
        sozaiArray.append(Drop(name: "狂の秘石", imagename: "kyouhi"))
        sozaiArray.append(Drop(name: "狂ピース", imagename: "kyoupi"))
        sozaiArray.append(Drop(name: "狂モニュメント", imagename: "kyoumo"))
        sozaiArray.append(Drop(name: "騎の輝石", imagename: "kiki"))
        sozaiArray.append(Drop(name: "騎の魔石", imagename: "kima"))
        sozaiArray.append(Drop(name: "騎の秘石", imagename: "kihi"))
        sozaiArray.append(Drop(name: "騎ピース", imagename: "kipi"))
        sozaiArray.append(Drop(name: "騎モニュメント", imagename: "kimo"))
        sozaiArray.append(Drop(name: "術の輝石", imagename: "jutuki"))
        sozaiArray.append(Drop(name: "術の魔石", imagename: "jutuma"))
        sozaiArray.append(Drop(name: "術の秘石", imagename: "jutuhi"))
        sozaiArray.append(Drop(name: "術ピース", imagename: "jutupi"))
        sozaiArray.append(Drop(name: "術モニュメント", imagename: "jutumo"))
        sozaiArray.append(Drop(name: "殺の輝石", imagename: "satuki"))
        sozaiArray.append(Drop(name: "殺の魔石", imagename: "satuma"))
        sozaiArray.append(Drop(name: "殺の秘石", imagename: "satuhi"))
        sozaiArray.append(Drop(name: "殺ピース", imagename: "satupi"))
        sozaiArray.append(Drop(name: "殺モニュメント", imagename: "satumo"))
        sozaiArray.append(Drop(name: "剣の輝石", imagename: "kenki"))
        sozaiArray.append(Drop(name: "剣の魔石", imagename: "kenma"))
        sozaiArray.append(Drop(name: "剣の秘石", imagename: "kenhi"))
        sozaiArray.append(Drop(name: "剣ピース", imagename: "kenpi"))
        sozaiArray.append(Drop(name: "剣モニュメント", imagename: "kenmo"))
        
        
//        questArray.append(Quest(area: "月曜 弓の修練場", name: "初級",stamina: 10, drop: [Drop(name:"英雄の証"),Drop(name: "狂骨"), Drop(name: "竜の牙"), Drop(name: "虚影の塵"), Drop(name: "隕蹄鉄"), Drop(name:"弓の輝石"), Drop(name:"弓ピース"), Drop(name:"弓モニュメント")]))
//        questArray.append(Quest(area: "月曜 弓の修練場", name: "中級", stamina: 20, drop: [Drop(name:"英雄の証"), Drop(name:"狂骨"), Drop(name:"竜の牙"), Drop(name:"虚影の塵"),Drop(name:"世界樹の種"),Drop(name:"鳳凰の羽根"), Drop(name:"隕蹄鉄"), Drop(name:"弓の輝石"), Drop(name:"弓の魔石"), Drop(name:"弓ピース"), Drop(name:"弓モニュメント")]))
//        questArray.append(questTemp("月曜 弓の修練場", "上級", 30, ["英雄の証", "虚影の塵", "世界樹の種", "鳳凰の羽根", "隕蹄鉄", "血の淚石", "弓の輝石", "弓の魔石", "弓の秘石", "弓ピース", "弓モニュメント"]))
//        questArray.append(questTemp("月曜 弓の修練場", "超級", 40, ["英雄の証", "虚影の塵", "世界樹の種", "鳳凰の羽根", "隕蹄鉄", "血の淚石", "弓の輝石", "弓の魔石", "弓の秘石", "弓ピース", "弓モニュメント"]))
//        questArray.append(questTemp("火曜 槍の修練場", "初級", 10, ["英雄の証", "狂骨", "虚影の塵", "ホムンクルスベビー", "槍の輝石", "槍ピース", "槍モニュメント"]))
//        questArray.append(questTemp("火曜 槍の修練場", "中級", 20, ["英雄の証", "狂骨", "虚影の塵",  "世界樹の種",  "ホムンクルスベビー", "槍の輝石", "槍の魔石", "槍ピース", "槍モニュメント"]))
//        questArray.append(questTemp("火曜 槍の修練場","上級" , 30, ["英雄の証", "虚影の塵",  "世界樹の種", "鳳凰の羽根",  "ホムンクルスベビー", "槍の輝石", "槍の魔石", "槍の秘石", "槍ピース", "槍モニュメント"]))
//        questArray.append(questTemp("火曜 槍の修練場","超級" , 40, ["英雄の証", "虚影の塵",  "世界樹の種", "鳳凰の羽根",  "ホムンクルスベビー", "槍の輝石", "槍の魔石", "槍の秘石", "槍ピース", "槍モニュメント"]))
//        questArray.append(questTemp("水曜 狂の修練場", "初級", 10, ["英雄の証", "虚影の塵",  "八連双晶", "狂の輝石", "狂ピース", "狂モニュメント"]))
//        questArray.append(questTemp("水曜 狂の修練場", "中級", 20, ["英雄の証", "虚影の塵",  "八連双晶", "混沌の爪", "狂の輝石", "狂の魔石", "狂ピース", "狂モニュメント"]))
//        questArray.append(questTemp("水曜 狂の修練場", "上級", 30, []))
//        questArray.append(questTemp("水曜 狂の修練場", "超級", 40, []))
//        questArray.append(questTemp("木曜 騎の修練場", "初級", 10, []))
//        questArray.append(questTemp("木曜 騎の修練場", "中級", 20, []))
//        questArray.append(questTemp("木曜 騎の修練場", "上級", 30, []))
//        questArray.append(questTemp("木曜 騎の修練場", "超級", 40, []))
//        questArray.append(questTemp("金曜 術の修練場", "初級", 10, []))
//        questArray.append(questTemp("金曜 術の修練場", "中級", 20, []))
//        questArray.append(questTemp("金曜 術の修練場", "上級", 30, []))
//        questArray.append(questTemp("金曜 術の修練場", "超級", 40, ["虚影の塵", "蛇の宝玉", "禁断の頁", "蛮神の心臓", "術の輝石", "術の魔石", "術の秘石", "術ピース", "術モニュメント"]))
//        questArray.append(questTemp("土曜 殺の修練場", "初級", 10, []))
//        questArray.append(questTemp("土曜 殺の修練場", "中級", 20, []))
//        questArray.append(questTemp("土曜 殺の修練場", "上級", 30, []))
//        questArray.append(questTemp("土曜 殺の修練場", "超級", 40, []))
//        questArray.append(questTemp("日曜 剣の修練場", "初級", 10, []))
//        questArray.append(questTemp("日曜 剣の修練場", "中級", 20, []))
//        questArray.append(questTemp("日曜 剣の修練場", "上級", 30, []))
//        questArray.append(questTemp("日曜 剣の修練場", "超級", 40, []))
     //   questArray.append(questTemp("", "", , []))
        
        questArray.append(questTemp("月曜 弓の修練場", "初級", 10, [0,1,2,3,15,29,32,33]))
        questArray.append(questTemp("月曜 弓の修練場", "中級", 20, [0,1,2,3,7,11,15,29,30,32,33]))
        questArray.append(questTemp("月曜 弓の修練場", "上級", 30, [0,3,7,11,15,23,29,30,31,32,33]))
        questArray.append(questTemp("月曜 弓の修練場", "超級", 40, [0,3,7,11,15,23,29,30,31,32,33]))
        questArray.append(questTemp("火曜 槍の修練場", "初級", 10, [0,1,3,14,34,37,38]))
        questArray.append(questTemp("火曜 槍の修練場", "中級", 20, [0,1,3,7,14,34,35,37,38]))
        questArray.append(questTemp("火曜 槍の修練場", "上級", 30, [0,3,7,14,34,35,36,37,38]))
        questArray.append(questTemp("火曜 槍の修練場", "超級", 40, [0,3,7,14,34,35,36,37,38]))
        questArray.append(questTemp("水曜 狂の修練場", "初級", 10, [0,3,9,39,42,43]))
        questArray.append(questTemp("水曜 狂の修練場", "中級", 20, [0,3,9,18,39,30,42,43]))
        questArray.append(questTemp("水曜 狂の修練場", "上級", 30, [0,3,9,18,39,30,41,42,43]))
        questArray.append(questTemp("水曜 狂の修練場", "超級", 40, [0,3,9,18,39,30,41,42,43]))
        questArray.append(questTemp("木曜 騎の修練場", "初級", 10, [2,3,15,44,47,48]))
        questArray.append(questTemp("木曜 騎の修練場", "中級", 20, [2,3,15,44,45,47,48]))
        questArray.append(questTemp("木曜 騎の修練場", "上級", 30, [2,3,15,20,44,45,46,47,48]))
        questArray.append(questTemp("木曜 騎の修練場", "超級", 40, [2,3,15,20,44,45,46,47,48]))
        questArray.append(questTemp("金曜 術の修練場", "初級", 10, [3,10,13,49,52,53]))
        questArray.append(questTemp("金曜 術の修練場", "中級", 20, [3,10,13,49,50,52,53]))
        questArray.append(questTemp("金曜 術の修練場", "上級", 30, [3,10,13,19,49,50,51,52,53]))
        questArray.append(questTemp("金曜 術の修練場", "超級", 40, [3,10,13,19,49,50,51,52,53]))
        questArray.append(questTemp("土曜 殺の修練場", "初級", 10, [2,3,8,12,54,57,58]))
        questArray.append(questTemp("土曜 殺の修練場", "中級", 20, [2,3,12,54,55,57,58]))
        questArray.append(questTemp("土曜 殺の修練場", "上級", 30, [2,3,12,24,54,55,56,57,58]))
        questArray.append(questTemp("土曜 殺の修練場", "超級", 40, [2,3,12,24,54,55,56,57,58]))
        questArray.append(questTemp("日曜 剣の修練場", "初級", 10, [0,1,2,3,12,17,59,62,63]))
        questArray.append(questTemp("日曜 剣の修練場", "中級", 20, [0,3,12,17,59,60,62,63]))
        questArray.append(questTemp("日曜 剣の修練場", "上級", 30, [0,3,12,16,17,59,60,61,62,63]))
        questArray.append(questTemp("日曜 剣の修練場", "超級", 40, [0,3,12,16,17,59,60,61,62,63]))


      //  questArray.append(questTemp("", "", , []))
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView.tag == 1{
            return areaArray.count
        }else{
            return selectedquestArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        
        if pickerView.tag == 1{
            selectedquestArray = []
            return areaArray[row]
        }else{
            return selectedquestArray[row].name + " (AP" + String(selectedquestArray[row].stamina) + ")"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            self.areaTextField.text = areaArray[row]
        }else{
            selectedquest = selectedquestArray[row]
            questTextField.text = selectedquestArray[row].name + " (AP" + String(selectedquestArray[row].stamina) + ")"
        }
    }
    
    //    func cancel() {
    //        self.questTextField.text = ""
    //        self.questTextField.endEditing(true)
    //    }
    
    func areadone() {
        for i in questArray {
            if i.area == areaTextField.text{
                print(i.area)
                selectedquestArray.append(Quest(area: i.area, name: i.name, stamina: i.stamina, drop: i.drop))
                
            }
        }
        questTextField.isHidden = false
        self.areaTextField.endEditing(true)
    }
    
    func questdone(){
        questTextField.endEditing(true)
        self.view.addSubview(startButton)
    }
    
    func start(sender: UIButton){
        if selectedquest.drop[0].name != "周回数"{
        selectedquest.drop.insert(Drop(name: "周回数", imagename: "ringo"), at: 0)
        print(selectedquest.drop[1])
        }
        let borderView: UIView = UIView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 1))
        borderView.backgroundColor = UIColor.black
        self.view.addSubview(borderView)
        let shuukaiLabel: UILabel = UILabel(frame: CGRect(x: 10, y: 210, width: self.view.bounds.width - 20, height: 40))
        self.view.addSubview(shuukaiLabel)
        shuukaiLabel.text = selectedquest.area + " " + selectedquest.name + " (AP" + String(selectedquest.stamina) + ")"

        shuukaiTableView = UITableView(frame: CGRect(x: 0, y: 280, width: self.view.bounds.width, height: self.view.bounds.height - 280))
        let nib: UINib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        shuukaiTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        shuukaiTableView.delegate = self
        shuukaiTableView.dataSource = self
        self.view.addSubview(shuukaiTableView)
        
        
        
        
//        var labelHeight: Int = 250
//        for i in selectedquest.drop{
//            var dropLabel: UILabel = UILabel(frame: CGRect(x: 20, y: labelHeight, width: 100, height: 20))
//            dropLabel.text = i
//            self.view.addSubview(dropLabel)
//            labelHeight += 40
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedquest.drop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)
            as! CustomTableViewCell
        print(selectedquest.drop[indexPath.row].imagename)
        cell.imageview.image = selectedquest.drop[indexPath.row].getImage()
        cell.sozaiLabel.text = "\(selectedquest.drop[indexPath.row].name)"
        cell.recordLabel.text = "\(selectedquest.drop[indexPath.row].count)"
        cell.delegate = self
        
        return cell
    }
    
    func plus(sender: Any){
        
    }
    
    func plus(_ cell: CustomTableViewCell) {
        
        let indexPath: IndexPath = shuukaiTableView.indexPath(for: cell)!
        
        let drop = selectedquest.drop[indexPath.row]
        drop.count += 1
        
        // tableviewを更新
        shuukaiTableView.reloadData()
    }
    
    func minus(_ cell: CustomTableViewCell) {
        let indexPath: IndexPath = shuukaiTableView.indexPath(for: cell)!
        let drop = selectedquest.drop[indexPath.row]
        drop.count += -1
        shuukaiTableView.reloadData()
        
    }
    
    func questTemp(_ area: String, _ name: String, _ stamina: Int, _ dropname:[Int]) -> Quest {
        
        var dropnums: [Int] = []
        var drops: [Drop] = []
        
        for i in 0 ..< dropname.count {
            
            dropnums.append(dropname[i])
        }
        
        for i in dropnums{
            drops.append(Drop(name: sozaiArray[i].name, imagename: sozaiArray[i].imagename))
        }
        return Quest(area: area, name: name, stamina: stamina, drop: drops)
    }
        
    
    

    
}







