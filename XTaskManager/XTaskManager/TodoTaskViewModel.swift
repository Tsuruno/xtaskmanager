//
//  TodoTaskViewModel.swift
//  XTaskManager
//
//  Created by Administrator on 2020/08/08.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import Foundation
import Combine
import Resolver

class TodoTaskViewModel: ObservableObject { // (1)
    @Published var taskRepository: TaskRepository = Resolver.resolve()
    @Published var taskCellViewModels = [TaskCellViewModel]() // (3)
    
    private var cancellables = Set<AnyCancellable>()
    
    init(priority: TaskPriority) {
        self.taskRepository.setPriority(priority)
        self.taskCellViewModels = testDataTasks.filter({$0.priority == priority}).map { task in // (2)
            TaskCellViewModel(task: task)
        }
        taskRepository.$tasks.map { tasks in
          tasks.map { task in
            TaskCellViewModel(task: task)
          }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
        print("aaaa")
    }
    
    func removeTasks(atOffsets indexSet: IndexSet) { // (4)
        taskCellViewModels.remove(atOffsets: indexSet)
    }
    
    func addTask(task: Task) { // (5)
        taskCellViewModels.append(TaskCellViewModel(task: task))
    }
}
