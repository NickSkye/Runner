
import UIKit
import SpriteKit

class GameViewController: UIViewController {

    
    var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
 */
        
        button = UIButton(frame: CGRect(x: self.view.frame.width/2 - 50 , y: self.view.frame.height/2, width: 100, height: 50))
        self.button.isHidden = false
        self.button.isEnabled = true
        button.backgroundColor = .blue
        button.setTitle("START", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        self.view.addSubview(button)
    }

    
    
    
    func buttonClicked(sender: UIButton!) {
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .resizeFill
        skView.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 2))
        self.button.isHidden = true
        self.button.isEnabled = false
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
  /*
    @IBAction func skinButtPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "mainToSkins", sender: self)
    }
    */

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
