//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Leandro Carvalho on 1/15/16.
//  Copyright © 2016 Schimmelpfeng. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operacao: String {
        case soma = "+"
        case subtrai = "-"
        case multiplica = "*"
        case divide = "/"
        case vazio = "Vazio"
        case clear = "Clear"
        
    }
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var btAudioPlayer: AVAudioPlayer!
    
    var numeroCorrente = ""
    var numeroDireta = ""
    var numeroEsquerda = ""
    var operacaoAtual: Operacao = Operacao.vazio
    var resultado = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try btAudioPlayer = AVAudioPlayer(contentsOfURL: soundURL)
            btAudioPlayer.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    @IBAction func botaoPressionado(btn: UIButton){
        playSound()
        numeroCorrente += "\(btn.tag)"
        resultLabel.text = numeroCorrente
    }

    func playSound(){
        if btAudioPlayer.playing {
            btAudioPlayer.stop()
        }
        
        btAudioPlayer.play()
        
    }

    @IBAction func somaPressionado(sender: AnyObject) {
        operacoes(Operacao.soma)
    }
    
    @IBAction func menosPressionado(sender: AnyObject) {
        operacoes(Operacao.subtrai)
    }
    
    @IBAction func divididoPressionado(sender: AnyObject) {
        operacoes(Operacao.divide)
    }
    
    @IBAction func multiPressionado(sender: AnyObject) {
        operacoes(Operacao.multiplica)
    }
    
    @IBAction func igualPressionado(sender: AnyObject) {
        operacoes(operacaoAtual)
    }
    
    
    @IBAction func clearPressionado(sender: AnyObject) {
        operacoes(Operacao.clear)
    }
    
    
    func operacoes(op: Operacao){
        playSound()
        if operacaoAtual != Operacao.vazio && operacaoAtual != Operacao.clear{
            
            if numeroCorrente != ""{
                
                
                numeroDireta = numeroCorrente
                numeroCorrente = ""
                
                if operacaoAtual == Operacao.soma {
                    resultado = "\(Double(numeroEsquerda)! + Double(numeroDireta)!)"
                }
                if operacaoAtual == Operacao.subtrai {
                    resultado = "\(Double(numeroEsquerda)! - Double(numeroDireta)!)"
                }
                if operacaoAtual == Operacao.multiplica {
                    resultado = "\(Double(numeroEsquerda)! * Double(numeroDireta)!)"
                }
                if operacaoAtual == Operacao.divide {
                    resultado = "\(Double(numeroEsquerda)! / Double(numeroDireta)!)"
                }
                
                numeroEsquerda = resultado
                
                resultLabel.text = resultado
            }
            
            
            operacaoAtual = op
            
        }else {
            numeroEsquerda = numeroCorrente
            numeroCorrente = ""
            operacaoAtual = op
        }
        
        if  operacaoAtual != Operacao.vazio{
         
            if operacaoAtual == Operacao.clear {
                numeroCorrente = ""
                numeroDireta = ""
                numeroEsquerda = ""
                operacaoAtual = op
                resultado = ""
                resultLabel.text = "0.0"
            }
            
        }

    }
    
}

