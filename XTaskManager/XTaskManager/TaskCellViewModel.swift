//
//  TaskCellViewModel.swift
//  XTaskManager
//
//  Created by Administrator on 2020/08/08.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable  { // (6)
  @Published var task: Task
  
  var id: String = ""
  @Published var completionStateIconName = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  static func newTask() -> TaskCellViewModel {
    TaskCellViewModel(task: Task(title: "", priority: .medium, completed: false))
  }
  
  init(task: Task) {
    self.task = task
    $task // (8)
      .map { $0.completed ? "checkmark.circle.fill" : "circle" }
      .assign(to: \.completionStateIconName, on: self)
      .store(in: &cancellables)

    $task // (7)
      .map { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }
  
}
