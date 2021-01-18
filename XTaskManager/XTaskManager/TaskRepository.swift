//
//  TaskRepository.swift
//  XTaskManager
//
//  Created by Administrator on 2020/08/08.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import Foundation
import Resolver

class BaseTaskRepository {
    @Published var tasks = [Task]()
    var priority: TaskPriority = .medium
}

protocol TaskRepository: BaseTaskRepository {
    func addTask(_ task: Task)
    func setPriority(_ priority: TaskPriority)
    func removeTask(_ task: Task)
    func updateTask(_ task: Task)
}

class LocalTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
    override init() {
        super.init()
        loadData()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
        saveData()
    }
    
    func setPriority(_ priority: TaskPriority){
        self.priority = priority
        self.tasks = testDataTasks.filter({$0.priority == priority})
    }
    
    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            saveData()
        }
    }
    
    func updateTask(_ task: Task) {
        if let index = self.tasks.firstIndex(where: { $0.id == task.id } ) {
            self.tasks[index] = task
            saveData()
        }
    }
    
    private func loadData() {
        //        if let retrievedTasks = try? Disk.retrieve("tasks.json", from: .documents, as: [Task].self) { // (1)
        //            self.tasks = retrievedTasks
        //        }
    }
    
    private func saveData() {
        //        do {
        //            try Disk.save(self.tasks, to: .documents, as: "tasks.json")
        //        }
        //        catch let error as NSError {
        //            fatalError("""
        //                Domain: \(error.domain)
        //                Code: \(error.code)
        //                Description: \(error.localizedDescription)
        //                Failure Reason: \(error.localizedFailureReason ?? "")
        //                Suggestions: \(error.localizedRecoverySuggestion ?? "")
        //                """)
        //        }
    }
}

class TestDataTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
    override init() {
        super.init()
    }
    
    func addTask(_ task: Task) {
        tasks.append(task)
    }
    func setPriority(_ priority: TaskPriority){
        self.priority = priority
        self.tasks = testDataTasks.filter({$0.priority == self.priority})
    }
    
    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
    
    func updateTask(_ task: Task) {
        if let index = self.tasks.firstIndex(where: { $0.id == task.id } ) {
            self.tasks[index] = task
        }
    }
}
