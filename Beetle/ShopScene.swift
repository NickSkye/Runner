

import SpriteKit
import Foundation


class ShopScene: SKScene {
    
    var gameStarted = Bool(false)
    var died = Bool(false)
    let coinSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitForCompletion: false)
    
    var score = Int(0)
    var scoreLbl = SKLabelNode()
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
    var newSkinBtn = SKSpriteNode()
    var buyTokensBtn = SKSpriteNode()
    
//add stuff to game elements such as createSkinsButton and then implement in createSkinScene.

    override func didMove(to view: SKView) {
        print("HERE")
        createShopScene()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("1")
        
        
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
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == newSkinBtn {
            let scene = NewSkinScene(size: (view?.bounds.size)!)
            let skView = view!
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = false
            scene.scaleMode = .resizeFill
            skView.presentScene(scene, transition: SKTransition.doorway(withDuration: 1))
        }
        else if (nodes(at: (touches.first?.location(in: self))!)[0] as? SKSpriteNode)! == buyTokensBtn {
            let scene = BuyTokensScene(size: (view?.bounds.size)!)
            let skView = view!
            skView.showsFPS = false
            skView.showsNodeCount = false
            skView.ignoresSiblingOrder = false
            scene.scaleMode = .resizeFill
            skView.presentScene(scene, transition: SKTransition.doorway(withDuration: 1))
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

    
    func createShopScene() {
        let hour = Calendar.current.component(.hour, from: Date())
        print("hour \(hour)")
        var background = SKSpriteNode(imageNamed: "city")
        if hour > 19 || hour < 7 {
            background = SKSpriteNode(imageNamed: "newBG")
        }
       // let background = SKSpriteNode(imageNamed: "bg")
        background.anchorPoint = CGPoint.init(x: 0, y: 0)
        //background.position = CGPoint(x:CGFloat(i) * self.frame.width, y:0)
        background.name = "background"
        background.size = (self.view?.bounds.size)!
        self.addChild(background)
        
        createBackBtn()
        createNewSkinBtn()
        createCoinsAmount()
        createBuyTokensBtn()
        
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
        tokenshopLbl.text = "\(tokensshop) Coins"
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
    
    func createNewSkinBtn() {
        newSkinBtn = SKSpriteNode(imageNamed: "flippys-friends")
        newSkinBtn.size = CGSize(width:100, height:100)
        newSkinBtn.position = CGPoint(x: self.frame.width / 4, y: self.frame.height - 150)
        newSkinBtn.zPosition = 8
        self.addChild(newSkinBtn)
    }
    
    func createBuyTokensBtn() {
        buyTokensBtn = SKSpriteNode(imageNamed: "buy-coins")
        buyTokensBtn.size = CGSize(width:100, height:100)
        buyTokensBtn.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.height - 150)
        buyTokensBtn.zPosition = 8
        self.addChild(buyTokensBtn)
    }
 }











