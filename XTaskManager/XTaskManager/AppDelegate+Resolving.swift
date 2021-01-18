//
//  AppDelegate+Resolving.swift
//  XTaskManager
//
//  Created by Administrator on 2020/09/13.
//  Copyright © 2020 Kota Tsuruno. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
    register { TestDataTaskRepository() as TaskRepository }.scope(application)
  }
}
