//
//  ViewController.swift
//  FaceIt
//
//  Created by Sam Goldfield on 3/10/17.
//  Copyright © 2017 samgdf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* VOLUME AT TOP
 
     mpVolumeViewParentView.backgroundColor = [UIColor clearColor];
     MPVolumeView *myVolumeView =
     [[MPVolumeView alloc] initWithFrame: mpVolumeViewParentView.bounds];
     [mpVolumeViewParentView addSubview: myVolumeView];
     [myVolumeView release];
     
     OR
     
     volumeHolder = [[UIView alloc] initWithFrame:CGRectMake(-5, self.topView.frame.size.height - 10, screenWidth + 10, 1)];
     [volumeHolder setBackgroundColor:[UIColor clearColor]];
     [self.topView addSubview:volumeHolder];
     volumeView = [[MPVolumeView alloc] initWithFrame:volumeHolder.bounds];
     [volumeView setVolumeThumbImage:[UIImage imageNamed:@"slider_image_2.png"] forState:UIControlStateNormal];
     volumeView.showsRouteButton = NO;
     volumeView.showsVolumeSlider = YES;
     volumeView.tintColor = [UIColor whiteColor];
     [volumeHolder addSubview:volumeView];
     
    */

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            updateUI() //only when iOS sets to outlet
        }
    }
    
    var expression = FacialExpression(eyes: .open, mouth: .grin) {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
    switch expression.eyes {
    case .open :
    faceView.eyesOpen = true
    case .closed:
    faceView.eyesOpen = false
    case .squinting:
    faceView.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.grin:0.5,.frown:-1.0,.smile: 1.0,.smirk:-0.5]
    
}

