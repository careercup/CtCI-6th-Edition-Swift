import Foundation

/*:
 15.3 Dining Philosophers: In the famouse dining philosophers problem, a bunch of philosophers are sitting around a circular table with one chopstick between them. A philosopher needs both chopsticks to eat and always picks up the left chopstick before the right one. A deadlock could potentially occur if all of the philosophers reached for the left chopstick at the same time. Using threads and locks, implement a simulation of the dining philosophers problem that prevents deadlock. 
 */

struct Fork {
    
    let number: Int
    fileprivate var _state = State.Initial
    
    let serialQueue = DispatchQueue(label: "Fork")
    
    enum State {
        case Initial
        case InUse
        case Free
    }
    
    init(number: Int) {
        self.number = number
    }
}

extension Fork: CustomStringConvertible {
    
    var state: State {
        get {
            var state = State.Initial
            serialQueue.sync {
                state = self._state
            }
            return state
        }
        set(newState) {
            serialQueue.sync {
                self._state = newState
            }
        }
    }
    
    var description: String {
        return "fork \(number) state \(state)"
    }
}

final class PhilosopherOp: Operation {
    
    let philosopher: String
    fileprivate(set) var _state = State.Initial
    fileprivate(set) var left: Fork
    fileprivate(set) var right: Fork
    
    fileprivate let serialQueue = DispatchQueue(label: "Operation")
    
    enum State {
        case Initial
        case Thinking
        case Eating
    }
    
    init(name: String, left: Fork, right: Fork) {
        self.philosopher = name
        self.left = left
        self.right = right
    }
}

extension PhilosopherOp {
    
    func usLeft() {
        left.state = .InUse
        updateState()
    }
    
    func useRight() {
        right.state = .InUse
        updateState()
    }
    
    func useBoth() {
        left.state = .InUse
        right.state = .InUse
        updateState()
    }
    
    func wait() {
        right.state = .Free
        left.state = .Free
        updateState()
    }
    
    private func updateState() {
        guard case left.state = Fork.State.InUse, case right.state = Fork.State.InUse else { return state = .Thinking }
        state = .Eating
    }
    
    override var isExecuting: Bool {
        return _state == .Eating
    }
    
    override var isFinished: Bool {
        return false
    }
    
    fileprivate var state: State {
        get {
            var state = State.Initial
            serialQueue.sync {
                state = self._state
            }
            return state
        }
        set(newState) {
            serialQueue.sync {
                self._state = newState
            }
        }
    }
    
    override var description: String {
        return "\(philosopher): state = \(state) left = \(left), right = \(right)"
    }
}

func runPhilosophers(philosophers: [PhilosopherOp], forks: [Fork]) {
    precondition(forks.count == philosophers.count, "number of forks must equal number of philosophers")
    let operationQueue = OperationQueue()
    operationQueue.maxConcurrentOperationCount = forks.count / 2
    operationQueue.addOperations(philosophers, waitUntilFinished: false)
    var philosophers = philosophers
    var eatingPhilosphers = [PhilosopherOp]()
    let useRight: (PhilosopherOp) -> () = { p in p.useRight() }
    let useLeft: (PhilosopherOp) -> () = { p in p.usLeft() }
    let useBoth: (PhilosopherOp) -> () = { p in p.useBoth() }
    let wait: (PhilosopherOp) -> () = { p in p.wait() }
    let funcs = [useRight, useLeft, wait, useBoth, wait]
    
    for _ in 0..<forks.count {
        eatingPhilosphers.forEach { p in
            p.wait()
        }
        eatingPhilosphers.removeAll()
        funcs.enumerated().forEach { i, f in
            f(philosophers[i])
        }
        philosophers.forEach { p in
            if p.state == .Eating {
                eatingPhilosphers.append(p)
            }
        }
        philosophers.forEach { p in
            print("\(p)")
        }
        let p = philosophers.remove(at: 0)
        philosophers.append(p)
    }
}


let forkCount = 5
var forks = (0..<forkCount).map { Fork(number: $0) }

var philosopherNames = ["b", "c", "d", "e"]

let firstPhilosopher = PhilosopherOp(name: "a", left: forks[0], right: forks.last!)
var philosophers = [firstPhilosopher]

for (i, _) in philosopherNames.enumerated() {
    let philosopher = PhilosopherOp(name: philosopherNames[i], left: forks[i + 1], right: forks[i])
    philosophers.append(philosopher)
}

runPhilosophers(philosophers: philosophers, forks: forks)
