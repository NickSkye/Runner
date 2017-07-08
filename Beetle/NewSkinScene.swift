

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
    let tokenshopLbl = SKLabelNode()
    var characters = [String]()
   
    
    //add stuff to game elements such as createSkinsButton and then implement in createSkinScene.
    
    override func didMove(to view: SKView) {
        print("HERE")
        createProfileScene()
        
        
        if UserDefaults.standard.array(forKey: "characters") != nil {
            
            characters = UserDefaults.standard.array(forKey: "characters") as! [String]
            
        } else {
            if characters.isEmpty {
                characters.append("bird1")
            }
            UserDefaults.standard.set(characters, forKey: "characters")
        }
        
        
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
            skView.presentScene(scene, transition: SKTransition.doorsCloseHorizontal(withDuration: 1))
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyFirstBtn {
            //THIS FUNCTION WILL ALLOW USERS TO ALWAYS SELECT FLIPPY
            
                if (UserDefaults.standard.object(forKey: "birdType") as! String) != "bird1" {
                    //if robobird not selected, select it
                    UserDefaults.standard.set("bird1", forKey: "birdType")
                }
                else {
                    //if robobird is selected, and clicked, unselect it and go back to default bird.
                    UserDefaults.standard.set("bird1", forKey: "birdType")
                }
            
        
            
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buySecondBtn {
            //if not bought
            if !(characters.contains("robobird1")) {
                
                var tokensshop = Int(0)
                if UserDefaults.standard.object(forKey: "currentTokens") != nil {
                    tokensshop = UserDefaults.standard.integer(forKey: "currentTokens")
                } else {
                    tokensshop = 0
                }
                
                if tokensshop < 1000 {
                    var alert = UIAlertView(title: "Not Enough Coins", message: "You need 1000 coins to buy Flippy's friend", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                else {
                    //alert asking to buy
                    let alert = UIAlertController(title: "Buy Friend?", message: "Are you sure you want to buy Robobird?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                        //run your function here
                        print("BOUGHT")
                        tokensshop -= 1000
                        UserDefaults.standard.set(tokensshop, forKey: "currentTokens")
                        self.characters.append("robobird1")
                        UserDefaults.standard.set(self.characters, forKey: "characters")
                        self.tokenshopLbl.text = "\(tokensshop)"
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    //if alert answer == yes  {
                    
                    
                    
                }
                
                
                
            }
            else { //if already bought this will enable it
                if (UserDefaults.standard.object(forKey: "birdType") as! String) != "robobird1" {
                    //if robobird not selected, select it
                    UserDefaults.standard.set("robobird1", forKey: "birdType")
                }
                else {
                    //if robobird is selected, and clicked, unselect it and go back to default bird.
                    UserDefaults.standard.set("bird1", forKey: "birdType")
                }
            }
            // still need to change image

            
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyThirdBtn {
            
            //if not bought
            if !(characters.contains("rainbowbird1")) {
                
                var tokensshop = Int(0)
                if UserDefaults.standard.object(forKey: "currentTokens") != nil {
                    tokensshop = UserDefaults.standard.integer(forKey: "currentTokens")
                } else {
                    tokensshop = 0
                }
                
                if tokensshop < 500 {
                    var alert = UIAlertView(title: "Not Enough Coins", message: "You need 1000 coins to buy Flippy's friend", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                else {
                    //alert asking to buy
                    let alert = UIAlertController(title: "Buy Friend?", message: "Are you sure you want to buy Rainbowbird?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                        //run your function here
                        print("BOUGHT")
                        tokensshop -= 500
                        UserDefaults.standard.set(tokensshop, forKey: "currentTokens")
                        self.characters.append("rainbowbird1")
                        UserDefaults.standard.set(self.characters, forKey: "characters")
                        self.tokenshopLbl.text = "\(tokensshop)"
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    //if alert answer == yes  {
                    
                    
                    
                }
                
                
                
            }
            else { //if already bought this will enable it
                if (UserDefaults.standard.object(forKey: "birdType") as! String) != "rainbowbird1" {
                    //if robobird not selected, select it
                    UserDefaults.standard.set("rainbowbird1", forKey: "birdType")
                }
                else {
                    //if robobird is selected, and clicked, unselect it and go back to default bird.
                    UserDefaults.standard.set("bird1", forKey: "birdType")
                }
            }
            // Still need to change image
        

        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyFourthBtn {
            
            if !(characters.contains("steveBird1")) {
                
                var tokensshop = Int(0)
                if UserDefaults.standard.object(forKey: "currentTokens") != nil {
                    tokensshop = UserDefaults.standard.integer(forKey: "currentTokens")
                } else {
                    tokensshop = 0
                }
                
                if tokensshop < 2  { //change to 200
                    var alert = UIAlertView(title: "Not Enough Coins", message: "You need 200 coins to buy Flippy's friend", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                else {
                    //alert asking to buy
                    let alert = UIAlertController(title: "Buy Friend?", message: "Are you sure you want to buy Steve?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                        //run your function here
                        print("BOUGHT")
                        tokensshop -= 2
                        UserDefaults.standard.set(tokensshop, forKey: "currentTokens")
                        self.characters.append("steveBird1")
                        UserDefaults.standard.set(self.characters, forKey: "characters")
                        self.tokenshopLbl.text = "\(tokensshop)"
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    //if alert answer == yes  {
                    
                    
                    
                }
                
                
                
            }
            else { //if already bought this will enable it
                if (UserDefaults.standard.object(forKey: "birdType") as! String) != "steveBird1" {
                    //if robobird not selected, select it
                    UserDefaults.standard.set("steveBird1", forKey: "birdType")
                }
                else {
                    //if robobird is selected, and clicked, unselect it and go back to default bird.
                    UserDefaults.standard.set("bird1", forKey: "birdType")
                    
                }
            }
            // still need to change image

        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyFifthBtn {
            if !(characters.contains("derpyBird1")) {
                
                var tokensshop = Int(0)
                if UserDefaults.standard.object(forKey: "currentTokens") != nil {
                    tokensshop = UserDefaults.standard.integer(forKey: "currentTokens")
                } else {
                    tokensshop = 0
                }
                
                if tokensshop < 5  { //change to 200
                    var alert = UIAlertView(title: "Not Enough Coins", message: "You need 5 coins to buy Flippy's friend", delegate: nil, cancelButtonTitle: "OK")
                    alert.show()
                }
                else {
                    //alert asking to buy
                    let alert = UIAlertController(title: "Buy Friend?", message: "Are you sure you want to buy Derp?", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                        //run your function here
                        print("BOUGHT")
                        tokensshop -= 5
                        UserDefaults.standard.set(tokensshop, forKey: "currentTokens")
                        self.characters.append("derpyBird1")
                        UserDefaults.standard.set(self.characters, forKey: "characters")
                        self.tokenshopLbl.text = "\(tokensshop)"
                    }))
                    alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
                    self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    //if alert answer == yes  {
                    
                    
                    
                }
                
                
                
            }
            else { //if already bought this will enable it
                if (UserDefaults.standard.object(forKey: "birdType") as! String) != "derpyBird1" {
                    //if robobird not selected, select it
                    UserDefaults.standard.set("derpyBird1", forKey: "birdType")
                }
                else {
                    //if robobird is selected, and clicked, unselect it and go back to default bird.
                    UserDefaults.standard.set("bird1", forKey: "birdType")
                    
                }
            }
        }    // still need to change image        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buySixthBtn {
            characters.append("robobird1")
            UserDefaults.standard.set(characters, forKey: "characters")
            print("6")
            // if not bought, pop up alert asking if want to buy for coins or cancel
            // if want to buy, subtract coins from total and add skin to owned characters in userdefaults, change image to one saying play as or something
            //if not do nothing
            //else if bought and clicked, set birdType in userdefaults to that bird type.
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
        var background = SKSpriteNode(imageNamed: "city")
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
        buyFourthBtn = SKSpriteNode(imageNamed: "steveBird1")
        buyFourthBtn.size = CGSize(width:100, height:100)
        buyFourthBtn.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.midY)
        buyFourthBtn.zPosition = 8
        buyFourthBtn.name = "buyFourthButton"
        self.addChild(buyFourthBtn)
    }
    
    func createFifthFriendBtn() {
        buyFifthBtn = SKSpriteNode(imageNamed: "derpyBird1")
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











