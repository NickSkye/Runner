

import SpriteKit

//TEST

struct CollisionBitMask {
    static let birdCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let flowerCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
    static let boostCategory:UInt32 = 0x1 << 4
}

extension GameScene{
    func createBird() -> SKSpriteNode {
        let bird = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("bird1"))
        bird.size = CGSize(width: 50, height: 50)
        bird.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.physicsBody?.linearDamping = 1.1
        bird.physicsBody?.restitution = 0
        bird.physicsBody?.categoryBitMask = CollisionBitMask.birdCategory
        bird.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        bird.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.flowerCategory | CollisionBitMask.groundCategory | CollisionBitMask.boostCategory
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        
        return bird
    }
    
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        print("restartbuttoncreated")
        
        statLbl = SKLabelNode(fontNamed: "Chalkduster")
        statLbl.text = "" //You Win!"
        statLbl.fontSize = 65
        statLbl.fontColor = SKColor.green
        statLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(statLbl)
        
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    
    
    func createPauseBtn() {
        pauseBtn = SKSpriteNode(imageNamed: "pause")
        pauseBtn.size = CGSize(width:40, height:40)
        pauseBtn.position = CGPoint(x: self.frame.width - 30, y: 30)
        pauseBtn.zPosition = 6
        self.addChild(pauseBtn)
    }
    
   
    //creates shop on main screen
    func createShopBtn() {
        //shows number of spendable coins in shop. NEED TO REMOVE COINS AND UPDATE USERDEFAULTS WHEN TOKENS SPENT
        var tokensshop = Int(0)
        if UserDefaults.standard.object(forKey: "currentTokens") != nil {
            tokensshop = UserDefaults.standard.integer(forKey: "currentTokens")
        } else {
            tokensshop = 0
        }
        let tokenshopLbl = SKLabelNode()
        tokenshopLbl.position = CGPoint(x: 0 , y: -30)
        tokenshopLbl.text = "\(tokensshop) Tokens"
        tokenshopLbl.zPosition = 5
        tokenshopLbl.fontSize = 12
        tokenshopLbl.fontName = "HelveticaNeue-Bold"
        
        shopBtn = SKSpriteNode(imageNamed: "shop")
        shopBtn.size = CGSize(width:70, height:70)
        shopBtn.position = CGPoint(x: self.frame.midX / 3 , y: 50)
        shopBtn.zPosition = 7
        self.addChild(shopBtn)
        shopBtn.addChild(tokenshopLbl)
    }
    
    func createProfileBtn() {
        profileBtn = SKSpriteNode(imageNamed: "profile")
        profileBtn.size = CGSize(width:70, height:70)
        profileBtn.position = CGPoint(x: self.frame.width - 50, y: self.frame.height - 70)
        profileBtn.zPosition = 7
        self.addChild(profileBtn)
    }
    
    
    func createBackBtn() {
        backBtn = SKSpriteNode(imageNamed: "pause")
        backBtn.size = CGSize(width:60, height:40)
        backBtn.position = CGPoint(x: self.frame.midX / 6, y: self.frame.height - 50)
        backBtn.zPosition = 8
        self.addChild(backBtn)
    }
    
    
    func createScoreLabel() -> SKLabelNode {
        let scoreLbl = SKLabelNode()
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.6)
        scoreLbl.text = "\(score)"
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 50
        scoreLbl.fontName = "HelveticaNeue-Bold"
        
        let scoreBg = SKShapeNode()
        scoreBg.position = CGPoint(x: 0, y: 0)
        scoreBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100), height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil)
        let scoreBgColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2))
        scoreBg.strokeColor = UIColor.clear
        scoreBg.fillColor = scoreBgColor
        scoreBg.zPosition = -1
        scoreLbl.addChild(scoreBg)
        return scoreLbl
    }
    
    func createTokenCollectedLabel() -> SKLabelNode {
        let tokenLbl = SKLabelNode()
        tokenLbl.position = CGPoint(x: self.frame.width / 7, y: self.frame.height / 2 + self.frame.height / 2.6)
        tokenLbl.text = "\(tokens)"
        tokenLbl.zPosition = 5
        tokenLbl.fontSize = 20
        tokenLbl.fontName = "HelveticaNeue-Bold"
        
        let tokenBg = SKShapeNode()
        tokenBg.position = CGPoint(x: 0, y: 0)
        tokenBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-25), y: CGFloat(-15), width: CGFloat(50), height: CGFloat(50)), cornerWidth: 25, cornerHeight: 25, transform: nil)
        let tokenBgColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2))
        tokenBg.strokeColor = UIColor.clear
        tokenBg.fillColor = tokenBgColor
        tokenBg.zPosition = -1
        tokenLbl.addChild(tokenBg)
        return tokenLbl
    }
    
    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 22)
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highscoreLbl.text = "Highest Score: \(highestScore)"
        } else {
            highscoreLbl.text = "Highest Score: 0"
        }
        highscoreLbl.zPosition = 5
        highscoreLbl.fontSize = 15
        highscoreLbl.fontName = "Helvetica-Bold"
        return highscoreLbl
    }
    
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.size = CGSize(width: 272, height: 150)
        logoImg.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 130)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 100)
        taptoplayLbl.text = "Tap anywhere to play"
        taptoplayLbl.fontColor = UIColor(red: 63/255, green: 79/255, blue: 145/255, alpha: 1.0)
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        taptoplayLbl.fontName = "HelveticaNeue"
        return taptoplayLbl
    }
    
    func createWalls() -> SKNode  {
        let coinNode = SKSpriteNode(imageNamed: "flower")
        coinNode.size = CGSize(width: 40, height: 40)
        coinNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        coinNode.physicsBody = SKPhysicsBody(rectangleOf: coinNode.size)
        coinNode.physicsBody?.affectedByGravity = false
        coinNode.physicsBody?.isDynamic = false
        coinNode.physicsBody?.categoryBitMask = CollisionBitMask.flowerCategory
        coinNode.physicsBody?.collisionBitMask = 0
        coinNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        coinNode.color = SKColor.blue
        
        ///////
        let boostNode = SKSpriteNode(imageNamed: "pause")
        boostNode.size = CGSize(width: 40, height: 40)
        boostNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        boostNode.physicsBody = SKPhysicsBody(rectangleOf: boostNode.size)
        boostNode.physicsBody?.affectedByGravity = false
        boostNode.physicsBody?.isDynamic = false
        boostNode.physicsBody?.categoryBitMask = CollisionBitMask.boostCategory
        boostNode.physicsBody?.collisionBitMask = 0
        boostNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        boostNode.color = SKColor.blue
        ///////
        
        wallPair = SKNode()
        wallPair.name = "wallPair"
        
        let topWall = SKSpriteNode(imageNamed: "pillar")
        let btmWall = SKSpriteNode(imageNamed: "pillar")
        
        let randomWidth = random(min: 380, max: 440)
        
        topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + randomWidth)
        btmWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - randomWidth)
        
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        topWall.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        topWall.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        btmWall.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        btmWall.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false
        
        topWall.zRotation = CGFloat(M_PI)
        
        //Randomly removes top or bottom wall or both// can change to different type of wall
        let randomTopWall = Int(random(min: 0, max: 20))
        if randomTopWall != 5 {
            wallPair.addChild(topWall)
            
        }
        let randomBottomWall = Int(random(min: 0, max: 20))
        if randomBottomWall != 5 {
            wallPair.addChild(btmWall)
        }
        wallPair.zPosition = 1
        
        let randomPosition = random(min: -250, max: 250)
        wallPair.position.y = wallPair.position.y +  randomPosition
        
        //make random here
        let randomNumberFlower = Int(random(min: 0, max: 15))
        if randomNumberFlower == 5 {
            wallPair.addChild(coinNode)
        }
        
        let randomNumberBoost = Int(random(min: 0, max: 50))
        if randomNumberBoost == 25 && randomNumberBoost != randomNumberFlower {
            wallPair.addChild(boostNode)
        }
        
        wallPair.run(moveAndRemove)
        
        return wallPair
    }
 
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }

}
