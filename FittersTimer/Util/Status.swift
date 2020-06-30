//
//  Status.swift
//  FittersTimer
//
//  Created by PASSTECH on 24/04/2019.
//  Copyright © 2019 Taek. All rights reserved.
//

import Foundation

class Status: NSObject
{
    static let sharedInstance = Status()
    
    var navi        : Navi = .Tabata
    var state       : State = .Prepare
    var Movement    : Movement = .Prepare
    var color       : Bool = true
    var order       : Bool = true
    
    override init()
    {
        super.init()
    }
    
    func getInstance()
    {
        
    }
    
    func putNavi(_ navi: Navi)
    {
        self.navi = navi
    }
    
    func getNavi() -> Navi
    {
        return navi
    }
    
    func putState(_ state: State)
    {
        self.state = state
    }
    
    func getState() -> State
    {
        return state
    }
    
    func putMovement(_ Movement: Movement)
    {
        self.Movement = Movement
    }
    
    func getMovement() -> Movement
    {
        return Movement
    }
    
    func getNaviString() -> String
    {
        switch navi {
        case .Tabata:
            return "Tabata"
        case .ForTime:
            return "ForTime"
        case .EMOM:
            return "EMOM"
        }
    }
    
    func getStateString() -> String
    {
        switch state {
        case .Prepare:
            return "Prepare"
        case .Work:
            return "Work"
        case .Round_Rest:
            return "Round_Rest"
        case .Round:
            return "Round"
        case .Cycle:
            return "Cycle"
        case .Cycle_Rest:
            return "Cycle_Rest"
            
        }
    }
    
    func getMovementString() -> String
    {
        switch Movement {
        
        case .Prepare:
            return "Prepare"
        case .Work:
            return "Work"
        case .Round_Rest:
            return "Round Rest"
        case .Cycle_Rest:
            return "Cycle Rest"
        case .End:
            return "End"
        }
    }
    
}

enum Navi
{
    case Tabata
    case ForTime
    case EMOM
}

enum State
{
    case Prepare
    case Work
    case Round_Rest
    case Round
    case Cycle
    case Cycle_Rest
}

enum Movement
{
    case Prepare
    case Work
    case Round_Rest
    case Cycle_Rest
    case End
}
