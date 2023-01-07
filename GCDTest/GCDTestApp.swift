//
//  GCDTestApp.swift
//  GCDTest
//
//  Created by Lee Yen Lin on 2023/1/7.
//

import SwiftUI

@main
struct GCDTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class RunGcd {
    func gcdSync() {
        /// 同步執行
        ///
        /// 會按照順序跑, 做完再跑下一個

        for i in 0 ... 10 {
            print("🔴: \(i)")
        }

        for i in 0 ... 10 {
            print("🟠: \(i)")
        }

        /// 若開新的Queue, 跑sync的話會Serial方式跑下去
        let queue = DispatchQueue(label: "SyncQueue")
        queue.sync {
            for i in 0 ... 10 {
                print("SyncQueue: \(i)")
            }
        }
        for i in 0 ... 10 {
            print("🟢: \(i)")
        }
    }

    func gcdAsync() {
        /// 非同步
        ///
        /// 若開新的Queue跑在async, 會跟main互相交叉跑

        /// 這邊1, 2會按順序跑, 但會跟外面的紅圈圈交錯著
        let queue = DispatchQueue(label: "AsyncQueue", attributes: .concurrent)
        queue.async {
            for i in 0 ... 10 {
                print("AsyncQueue1: \(i)")
            }

            for i in 0 ... 10 {
                print("AsyncQueue2: \(i)")
            }
        }

        for i in 0 ... 10 {
            print("🔴: \(i)")
        }
    }

    func gcdAsyncBlock() {
        /// 非同步
        ///
        /// 若碰到sync 會把前面的sync跑完 再往下走(async不受影響)

        /// 這邊1, 2會按順序跑, 但會跟外面的紅圈圈交錯著
        let q = DispatchQueue(label: "Async")
        q.async {
            for i in 0 ... 10 {
                print("🔴: \(i)")
            }
        }

        for i in 0 ... 10 {
            print("Main: \(i)")
        }

        /// 到這裡main一定會先跑玩, 但紅的不一定 , 所以下面可能紅綠黃交錯跑
        q.async {
            for i in 0 ... 10 {
                print("🟢: \(i)")
            }
        }

        for i in 0 ... 10 {
            print("🟠: \(i)")
        }
    }

    func gcdAsyncConcurrent() {
        /// 非同步, 並行
        ///
        /// 如果把工作加到新的Queue預設會是Serial

        /// 以下為紅跑完跑率  同時穿插Main進去
        let queue = DispatchQueue(label: "AsyncDefault")
        queue.async {
            for i in 0 ... 10 {
                print("🔴: \(i)")
            }
        }
        queue.async {
            for i in 0 ... 10 {
                print("🟢: \(i)")
            }
        }
        for i in 0 ... 10 {
            print("Main: \(i)")
        }

        Thread.sleep(forTimeInterval: 1)
        print("----wait for done----")

        /// 要跑concurrent的話就改以下
        /// 這樣紅綠就會交錯  並與外面Main交錯
        let queue2 = DispatchQueue(label: "AsyncConcurrent", attributes: .concurrent)
        queue2.async {
            for i in 0 ... 10 {
                print("🔴: \(i)")
            }
        }
        queue2.async {
            for i in 0 ... 10 {
                print("🟢: \(i)")
            }
        }
        for i in 0 ... 10 {
            print("Main: \(i)")
        }
    }
}
