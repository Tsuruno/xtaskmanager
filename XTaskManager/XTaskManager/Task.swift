//
//  Task.swift
//  XTaskManager
//
//  Created by Administrator on 2020/08/08.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import Foundation

enum TaskPriority{
    case high //右上
    case medium //左上
    case low //左下
}

struct Task: Identifiable{
    var id: String = UUID().uuidString
    var title: String
    var priority: TaskPriority
    var completed: Bool
}

#if DEBUG
let testDataTasks = [
    Task(title: "レポート提出", priority: .low, completed: false),
    Task(title: "スーパー買い物", priority: .medium, completed: false),
    Task(title: "ああああああ", priority: .high, completed: false),
    Task(title: "曲提出", priority: .low, completed: false),
    Task(title: "ゲーム", priority: .medium, completed: false),
    Task(title: "いいいいいいい", priority: .high, completed: false),
    Task(title: "task1", priority: .low, completed: true),
    Task(title: "task2", priority: .medium, completed: true),
    Task(title: "task3", priority: .high, completed: true),
    Task(title: "task4", priority: .low, completed: true),
    Task(title: "task5", priority: .medium, completed: true),
    Task(title: "task6", priority: .high, completed: true),
    Task(title: "task7", priority: .low, completed: true),
    Task(title: "task8", priority: .medium, completed: true),
    Task(title: "task9", priority: .high, completed: true)
]
#endif
