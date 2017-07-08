

import SpriteKit

//TEST

struct CollisionBitMask {
    static let birdCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let flowerCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
    static let boostCategory:UInt32 = 0x1 << 4
    static let scoreCategory:UInt32 = 0x1 << 5
    static let killerPillarCategory:UInt32 = 0x1 << 6
    static let bigBirdCategory:UInt32 = 0x1 << 7
    static let invincibleCategory:UInt32 = 0x1 << 8
}



extension GameScene{
    
    //CHANGE all values affecting size x,y to be x/414 * width or y/736 * height
    
    func createBird(birdType: String) -> SKSpriteNode {
        let bird = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed(birdType)) //pass first bird
        bird.size = CGSize(width: (self.frame.width * 0.121), height: (self.frame.height * 0.068))
        bird.position = CGPoint(x:self.frame.midX, y:self.frame.midY)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.width / 2)
        bird.physicsBody?.linearDamping = 1.1
        bird.physicsBody?.restitution = 0
        bird.physicsBody?.categoryBitMask = CollisionBitMask.birdCategory
        bird.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory
        bird.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.flowerCategory | CollisionBitMask.groundCategory | CollisionBitMask.boostCategory | CollisionBitMask.killerPillarCategory | CollisionBitMask.bigBirdCategory
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.isDynamic = true
        print("\(self.frame.width) X \(self.frame.height)")
        
        return bird
    }
    
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "restart")
        restartBtn.size = CGSize(width:100, height:100)
        restartBtn.position = CGPoint(x: self.frame.width / 4, y: self.frame.height / 2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        print("restartbuttoncreated")
        
        adBtn = SKSpriteNode(imageNamed: "double-coins")
        adBtn.size = CGSize(width:100, height:100)
        adBtn.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.height / 2)
        adBtn.zPosition = 6
        adBtn.setScale(0)
        self.addChild(adBtn)
        print("restartbuttoncreated")
        /*
        statLbl = SKLabelNode(fontNamed: "Chalkduster")
        statLbl.text = "" //You Win!"
        statLbl.fontSize = 65
        statLbl.fontColor = SKColor.green
        statLbl.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(statLbl)
        */
        adBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
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
        tokenshopLbl.text = "\(tokensshop) Coins"
        tokenshopLbl.zPosition = 5
        tokenshopLbl.fontSize = 12
        tokenshopLbl.fontColor = UIColor(red: 238/255, green: 221/255, blue: 130/255, alpha: 1)
        tokenshopLbl.fontName = "HelveticaNeue-Bold"
        
        shopBtn = SKSpriteNode(imageNamed: "shop")
        shopBtn.size = CGSize(width:80, height:80)
        shopBtn.position = CGPoint(x: self.frame.midX / 3 , y: self.frame.height * 0.1)
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
    
    func createGameCenterBtn() {
        gcBtn = SKSpriteNode(imageNamed: "gamecenter")
        gcBtn.size = CGSize(width:70, height:70)
        gcBtn.position = CGPoint(x: self.frame.width * 0.8 , y: self.frame.height * 0.1)
        gcBtn.zPosition = 7
        self.addChild(gcBtn)
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
        coinNode.name = "backgroundStuff"
        
        ///////
        let boostChange = CGFloat(random(min: -100.0, max: 100.0))
        let boostNode = SKSpriteNode(imageNamed: "portal")
        boostNode.size = CGSize(width: 70, height: 100)
        boostNode.position = CGPoint(x: self.frame.width + 25, y: (self.frame.height / 2) + boostChange)
        boostNode.physicsBody = SKPhysicsBody(rectangleOf: boostNode.size)
        boostNode.physicsBody?.affectedByGravity = false
        boostNode.physicsBody?.isDynamic = false
        boostNode.setScale(0.2)
        boostNode.physicsBody?.categoryBitMask = CollisionBitMask.boostCategory
        boostNode.physicsBody?.collisionBitMask = 0
        boostNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        boostNode.color = SKColor.blue
        boostNode.name = "backgroundStuff"
        
        
        ///////
        let scorerNode = SKSpriteNode(imageNamed: "pillar")
        scorerNode.size = CGSize(width: 10, height: self.frame.height * 2)
        scorerNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        scorerNode.physicsBody = SKPhysicsBody(rectangleOf: scorerNode.size)
        scorerNode.physicsBody?.affectedByGravity = false
        scorerNode.physicsBody?.isDynamic = false
        scorerNode.setScale(1)
        scorerNode.physicsBody?.categoryBitMask = CollisionBitMask.scoreCategory
        scorerNode.physicsBody?.collisionBitMask = 0
        scorerNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        scorerNode.color = SKColor.blue
        scorerNode.alpha = 0.2
        scorerNode.name = "backgroundStuff"
        
        
        //////
        let killerPillarNode = SKSpriteNode(imageNamed: "laserbeam")
        killerPillarNode.size = CGSize(width: 40, height: self.frame.height)
        killerPillarNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        killerPillarNode.physicsBody = SKPhysicsBody(rectangleOf: killerPillarNode.size)
        killerPillarNode.physicsBody?.affectedByGravity = false
        killerPillarNode.physicsBody?.isDynamic = false
        killerPillarNode.setScale(1)
        killerPillarNode.physicsBody?.categoryBitMask = CollisionBitMask.killerPillarCategory
        killerPillarNode.physicsBody?.collisionBitMask = 0
        killerPillarNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        killerPillarNode.color = SKColor.blue
        killerPillarNode.name = "backgroundStuff"
        
        
        let killerPillarTopNode = SKSpriteNode(imageNamed: "laserbeam")
        killerPillarTopNode.size = CGSize(width: 40, height: self.frame.height)
        killerPillarTopNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2)
        killerPillarTopNode.physicsBody = SKPhysicsBody(rectangleOf: killerPillarTopNode.size)
        killerPillarTopNode.physicsBody?.affectedByGravity = false
        killerPillarTopNode.physicsBody?.isDynamic = false
        killerPillarTopNode.setScale(1)
        killerPillarTopNode.physicsBody?.categoryBitMask = CollisionBitMask.killerPillarCategory
        killerPillarTopNode.physicsBody?.collisionBitMask = 0
        killerPillarTopNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        killerPillarTopNode.color = SKColor.blue
        
        killerPillarTopNode.zRotation = CGFloat(M_PI)
        killerPillarTopNode.name = "backgroundStuff"
        
        /////
        wallPair = SKNode()
        wallPair.name = "wallPair"
        
        let topWall = SKSpriteNode(imageNamed: "pillar")
        let btmWall = SKSpriteNode(imageNamed: "pillar")
        
        let randomWidth = random(min: 380, max: 440)
        
        topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + randomWidth)
        btmWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - randomWidth)
        killerPillarNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 450)
        killerPillarTopNode.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 450)
        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        topWall.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        topWall.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        topWall.name = "backgroundStuff"
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
        btmWall.physicsBody?.collisionBitMask = CollisionBitMask.birdCategory
        btmWall.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        btmWall.physicsBody?.isDynamic = false
        btmWall.physicsBody?.affectedByGravity = false
        btmWall.name = "backgroundStuff"
        
        topWall.zRotation = CGFloat(M_PI)
        
        //Randomly removes top or bottom wall or both// can change to different type of wall
        let randomTopWall = Int(random(min: 0, max: 20))
        if randomTopWall != 5 {
            wallPair.addChild(topWall)
            
        }
        let randomBottomWall = Int(random(min: 0, max: 10))
        if randomBottomWall != 5 {
            wallPair.addChild(btmWall)
            
        } else {
            wallPair.addChild(killerPillarNode)
            run(saberSound)
        }
        
         let randomDoubleLaser = Int(random(min: 0, max: 30))
        if randomDoubleLaser == 15 {
            wallPair.removeAllChildren()
            run(saberSound)
            
            wallPair.addChild(killerPillarNode)
            wallPair.addChild(killerPillarTopNode)
        }
        
        
        
        wallPair.zPosition = 1
        
        let randomPosition = random(min: -210, max: 210)
        wallPair.position.y = wallPair.position.y +  randomPosition
        
        //make random here
        //TOKEN
        let randomNumberFlower = Int(random(min: 0, max: 15))
        if randomNumberFlower == 5 {
            wallPair.addChild(coinNode)
            
        }
        let randomWallMove = Int(random(min: 0, max: 8))
        if randomWallMove == 6 {
            //wallPair.run(SKAction .moveTo(y: wallPair.position.y + 150, duration: 4.0))
            wallPair.run(SKAction .moveBy(x: 0, y: 150, duration: 4.0))
            
        }
        
        if randomWallMove == 4 {
            //wallPair.run(SKAction .moveTo(y: wallPair.position.y - 150, duration: 4.0))
            wallPair.run(SKAction .moveBy(x: 0, y: -150, duration: 4.0))
        }
        
        //BOOST
        let randomNumberBoost = Int(random(min: 0, max: 10))
        if randomNumberBoost == 7 && randomNumberBoost != 5 {
            wallPair.addChild(boostNode)
            boostNode.run(SKAction.scale(to: 1.0, duration: 1))
        }
        wallPair.addChild(scorerNode)
        
        wallPair.run(moveAndRemove)
        
        return wallPair
    }
    
    // Create bigger bird
    func createBigBird() -> SKNode  {
        
        
        let bigBirdNode = SKSpriteNode(imageNamed: "eagle")
        bigBirdNode.size = CGSize(width: 50, height: 50)
        
        bigBirdNode.physicsBody = SKPhysicsBody(rectangleOf: bigBirdNode.size)
        bigBirdNode.physicsBody?.affectedByGravity = false
        bigBirdNode.physicsBody?.isDynamic = false
        bigBirdNode.physicsBody?.categoryBitMask = CollisionBitMask.bigBirdCategory
        bigBirdNode.physicsBody?.collisionBitMask = 0
        bigBirdNode.physicsBody?.contactTestBitMask = CollisionBitMask.birdCategory
        bigBirdNode.color = SKColor.blue
        bigBirdNode.zPosition = 10
        bigBirdNode.setScale(2.0)
        /////
        bigBirdObstacle = SKNode()
        bigBirdObstacle.name = "bigBird"
        
       
        
        //let randomWidthBird = random(min: -150, max: 150)
        
       bigBirdNode.position = CGPoint(x: self.frame.width - 25, y: self.frame.midY) // + randomWidthBird)
        
        
        //Randomly removes top or bottom wall or both// can change to different type of wall
        let randomBigBird = Int(random(min: 0, max: 20))
        if randomBigBird == 10 && score > 10{
            bigBirdObstacle.addChild(bigBirdNode)
            print("BIG BIRD CREATED")
            run(hawk)
            
        }
        
        
        
        bigBirdObstacle.zPosition = 10
        
        let randomPosition = random(min: -250, max: 250)
        bigBirdObstacle.position.y = bigBirdObstacle.position.y +  randomPosition
        
        //make random here
        //TOKEN
       
        
        
        
        
        //bigBirdObstacle.addChild(bigBirdNode)
        
        bigBirdObstacle.run(moveAndRemoveBigBird)
        
        return bigBirdObstacle
    }

    
    
    ////
 
    
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
        return random() * (max - min) + min
    }

}
