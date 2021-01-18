//
//  TodoTaskView.swift
//  XTaskManager
//
//  Created by Administrator on 2020/08/06.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import SwiftUI

//タスクビュー(一区切り)
struct TodoTaskView: View {
    
    let priority: TaskPriority
    @ObservedObject var taskListVM : TodoTaskViewModel
    @State var presentAddNewItem = false
    
    init(priority: TaskPriority){
        self.priority = priority
        self.taskListVM = TodoTaskViewModel(priority: priority)
    }
    
    var body: some View {
        //NavigationView {
        VStack(alignment: .leading) {
            List {
                Section(header: Text("Important/urgent")){
                    ForEach (taskListVM.taskCellViewModels.filter({$0.task.completed == false})) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                        //self.taskListVM.taskRepository.updateTask(self.)
                    }
                    .onDelete { indexSet in
                        self.taskListVM.removeTasks(atOffsets: indexSet)
                    }
                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel.newTask()) { result in
                            if case .success(let task) = result {
                                self.taskListVM.addTask(task: task)
                            }
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
                //Present Finished
                Section(header: Text("Finished")){
                    ForEach (taskListVM.taskCellViewModels.filter({$0.task.completed == true})) { taskCellVM in
                        TaskCell(taskCellVM: taskCellVM)
                    }
                    .onDelete { indexSet in
                        self.taskListVM.removeTasks(atOffsets: indexSet)
                    }
                }
            }
            //            Button(action: { self.presentAddNewItem.toggle() }) {
            //                HStack {
            //                    Image(systemName: "plus.circle.fill")
            //                        .resizable()
            //                        .frame(width: 20, height: 20)
            //                    Text("New Task")
            //                }
            //            }
            //            .padding()
            //            .accentColor(Color(UIColor.systemRed))
        }
        .navigationBarTitle("Task")
        
    }
    
    
    func update(changed: Bool) {
        guard !changed else { return }
    }
    
    func print(){
        
    }
}

struct TodoTaskView_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            TodoTaskView(priority: .high)
            
            TodoTaskView(priority: .low)
        }
    }
}


struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel // (1)
    var onCommit: (Result<Task, InputError>) -> Void = { _ in } // (5)
    
    var body: some View {
        HStack {
            TextField("Enter task title", text: $taskCellVM.task.title, // (3)
                onCommit: { //(4)
                    if !self.taskCellVM.task.title.isEmpty {
                        self.onCommit(.success(self.taskCellVM.task))
                    }
                    else {
                        self.onCommit(.failure(.empty))
                    }
            }).id(taskCellVM.id)
            
            Image(systemName: taskCellVM.completionStateIconName) // (2)
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
            }.id(taskCellVM.id)
        }
    }
}

enum InputError: Error {
    case empty
}


