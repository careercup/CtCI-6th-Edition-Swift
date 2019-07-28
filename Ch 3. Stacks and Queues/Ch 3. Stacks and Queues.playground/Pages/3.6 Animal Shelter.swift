enum AnimalType: Int {
    case cat = 0
    case dog = 1
}


public class Animal {
    
    let animalType: AnimalType
    
    init(animalType: AnimalType) {
        self.animalType = animalType
    }
}

extension Animal: Equatable {
    public static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.animalType == rhs.animalType
    }
}

public class AnimalQueue {
    private var items: [Animal] = []
    
    func enqueue(_ item: Animal) {
        items.append(item)
    }
    
    func dequeue() -> Animal? {
        guard items.count > 0 else { return nil }
        return items.removeFirst()
    }
    
    func dequeue(animalType: AnimalType) -> Animal? {
        guard items.count > 0 else { return nil }
        for index in 0..<items.count {
            if items[index].animalType == animalType {
                let firstOfType = items[index]
                items.remove(at: index)
                return firstOfType
            }
        }
        return nil
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
}
