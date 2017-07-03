

import SpriteKit
import Foundation


class NewSkinScene: SKScene {
    
    var gameStarted = Bool(false)
    var died = Bool(false)
    let coinSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    
    var score = Int(0)
    var scoreLbl = SKLabelNode()
    var buyFirstBtn = SKSpriteNode()
    var buySecondBtn = SKSpriteNode()
    var buyThirdBtn = SKSpriteNode()
    var buyFourthBtn = SKSpriteNode()
    var buyFifthBtn = SKSpriteNode()
    var buySixthBtn = SKSpriteNode()
    var highscoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var restartBtn = SKSpriteNode()
    var pauseBtn = SKSpriteNode()
    var skinBtn = SKSpriteNode()
    var logoImg = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var movePipes = SKAction()
    var distance = CGFloat()
    //CREATE THE BIRD ATLAS FOR ANIMATION
    let birdAtlas = SKTextureAtlas(named:"player")
    var birdSprites = Array<SKTexture>()
    var bird = SKSpriteNode()
    var repeatActionbird = SKAction()
    var delay = SKAction()
    var SpawnDelay = SKAction()
    var spawnDelayForever = SKAction()
    var spawn = SKAction()
    var time = CGFloat()
    var backBtn = SKSpriteNode()
    
    //add stuff to game elements such as createSkinsButton and then implement in createSkinScene.
    
    override func didMove(to view: SKView) {
        print("HERE")
        createProfileScene()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        // Create the method you want to call (see target before)
        
        // put all menu items on scene here as else if using same notation. CTRL-f menu items to find where to remove them on this page
        
        if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == backBtn {
            let scene = GameScene(size: (view?.bounds.size)!)
            let skView = view!
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = false
            scene.scaleMode = .resizeFill
            skView.presentScene(scene, transition: SKTransition.doorway(withDuration: 1))
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyFirstBtn {
            
            /*
            let alert = UIAlertController(title: "UIAlertController", message: "Would you like to unlock Flippy's friend for 100 coins?", preferredStyle: UIAlertControllerStyle.alert)
            
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
                print("Click of default button")
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { action in
                print("Click of default button")
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil) */
            
            //if bought && if selected
            //UserDefaults.standard.set("robobird1", forKey: "birdType")
            print("1")
            
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buySecondBtn {
            print("2")
            
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyThirdBtn {
            
            print("3")
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyFourthBtn {
            
            print("4")
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyFifthBtn {
            
            print("5")
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buySixthBtn {
            
            print("6")
        }
        //
        
        
        
        /// was here V
        ///moved touches here
        for touch in touches{
            let location = touch.location(in: self)
            //let node = self.nodes(at: location)
            /* CHANGE THIS TO GO TO A NEW SCENE WITH NEW CHARACTERS
             if (nodes(at: touch.location(in: self))[0] as? SKSpriteNode) == shopBtn {
             let skinscene = SkinsScene(size: (view?.bounds.size)!)
             let skinskView = view!
             skinskView.showsFPS = false
             skinskView.showsNodeCount = false
             skinskView.ignoresSiblingOrder = false
             skinscene.scaleMode = .resizeFill
             skinskView.presentScene(skinscene, transition: SKTransition.doorway(withDuration: 2))
             shopBtn.removeFromParent()
             }
             */
            
        }
        
        ////
        //////
    }
    
    
    func createProfileScene() {
       
        let hour = Calendar.current.component(.hour, from: Date())
        print("hour \(hour)")
        var background = SKSpriteNode(imageNamed: "bg")
        if hour > 19 || hour < 7 {
            background = SKSpriteNode(imageNamed: "newBG")
        }
        //let background = SKSpriteNode(imageNamed: "bg")
        background.anchorPoint = CGPoint.init(x: 0, y: 0)
        //background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
        background.name = "background"
        background.size = (self.view?.bounds.size)!
        self.addChild(background)
        
        createBackBtn()
        createCoinsAmount()
        createLogo()
        createFirstFriendBtn()
        createSecondFriendBtn()
        createThirdFriendBtn()
        createFourthFriendBtn()
        createFifthFriendBtn()
        createSixthFriendBtn()
    }
    
    func createCoinsAmount() {
        var tokensshop = Int(0)
        if UserDefaults.standard.object(forKey: "currentTokens") != nil {
            tokensshop = UserDefaults.standard.integer(forKey: "currentTokens")
        } else {
            tokensshop = 0
        }
        let tokenshopLbl = SKLabelNode()
        tokenshopLbl.position = CGPoint(x: self.frame.width - 50 , y: self.frame.height - 50)
        tokenshopLbl.text = "\(tokensshop)"
        tokenshopLbl.fontColor = UIColor(red: 238/255, green: 221/255, blue: 130/255, alpha: 1)
        tokenshopLbl.zPosition = 5
        tokenshopLbl.fontSize = 20
        tokenshopLbl.fontName = "HelveticaNeue-Bold"
        self.addChild(tokenshopLbl)
    }
    
    func createBackBtn() {
        backBtn = SKSpriteNode(imageNamed: "backbutton")
        backBtn.size = CGSize(width:60, height:40)
        backBtn.position = CGPoint(x: self.frame.midX / 6, y: self.frame.height - 50)
        backBtn.zPosition = 8
        self.addChild(backBtn)
    }
    
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "flippysfriends")
        logoImg.size = CGSize(width: 272, height: 150)
        logoImg.position = CGPoint(x:self.frame.midX, y:self.frame.height * 0.9)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.5))
    }
    
    func createFirstFriendBtn() {
        buyFirstBtn = SKSpriteNode(imageNamed: "play")
        buyFirstBtn.size = CGSize(width:100, height:100)
        buyFirstBtn.position = CGPoint(x: self.frame.midX / 2, y: self.frame.height * 0.7)
        buyFirstBtn.zPosition = 8
        buyFirstBtn.name = "buyFirstButton"
        self.addChild(buyFirstBtn)
    }
    
    func createSecondFriendBtn() {
        buySecondBtn = SKSpriteNode(imageNamed: "play")
        buySecondBtn.size = CGSize(width:100, height:100)
        buySecondBtn.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.height * 0.7)
        buySecondBtn.zPosition = 8
        buySecondBtn.name = "buySecondButton"
        self.addChild(buySecondBtn)
    }
    
    func createThirdFriendBtn() {
        buyThirdBtn = SKSpriteNode(imageNamed: "play")
        buyThirdBtn.size = CGSize(width:100, height:100)
        buyThirdBtn.position = CGPoint(x: self.frame.midX / 2, y: self.frame.midY)
        buyThirdBtn.zPosition = 8
        buyThirdBtn.name = "buyThirdButton"
        self.addChild(buyThirdBtn)
    }
    
    func createFourthFriendBtn() {
        buyFourthBtn = SKSpriteNode(imageNamed: "play")
        buyFourthBtn.size = CGSize(width:100, height:100)
        buyFourthBtn.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.midY)
        buyFourthBtn.zPosition = 8
        buyFourthBtn.name = "buyFourthButton"
        self.addChild(buyFourthBtn)
    }
    
    func createFifthFriendBtn() {
        buyFifthBtn = SKSpriteNode(imageNamed: "play")
        buyFifthBtn.size = CGSize(width:100, height:100)
        buyFifthBtn.position = CGPoint(x: self.frame.midX / 2, y: self.frame.midY / 2)
        buyFifthBtn.zPosition = 8
        buyFifthBtn.name = "buyFifthButton"
        self.addChild(buyFifthBtn)
    }

    func createSixthFriendBtn() {
        buySixthBtn = SKSpriteNode(imageNamed: "play")
        buySixthBtn.size = CGSize(width:100, height:100)
        buySixthBtn.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.midY / 2)
        buySixthBtn.zPosition = 8
        buySixthBtn.name = "buySixthButton"
        self.addChild(buySixthBtn)
    }
    
    
    
}











