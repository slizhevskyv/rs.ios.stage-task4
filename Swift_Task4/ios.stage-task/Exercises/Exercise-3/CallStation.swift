import Foundation

final class CallStation {
    var userSet: Set<User> = [];
    var callArray: [Call] = [];
    var callsByUser: [User: [Call]] = [:];
}

extension CallStation: Station {
    func users() -> [User] {
        return Array(self.userSet);
    }
    
    func add(user: User) {
        self.userSet.insert(user);
    }
    
    func remove(user: User) {
        self.userSet.remove(user);
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(let from, let to):
            if (!userSet.contains(from) && !userSet.contains(to)) {
                return nil;
            }
            
            let callId = CallID();
            var callStatus: CallStatus = .calling;
            
            if (!userSet.contains(to)) {
                callStatus = .ended(reason: .error);
            }
            
            if let _ = self.currentCall(user: to) {
                callStatus = .ended(reason: .userBusy);
            }
            
            let call = Call(
                id: callId,
                incomingUser: from,
                outgoingUser: callStatus == .ended(reason: .userBusy) ? nil : to,
                status: callStatus
            );
            
            self.callArray.append(call);
            
            if self.callsByUser[from] != nil {
                self.callsByUser[from]!.append(call);
            } else {
                self.callsByUser[from] = [call];
            }
            
            if self.callsByUser[to] != nil {
                self.callsByUser[to]!.append(call);
            } else {
                self.callsByUser[to] = [call];
            }
            
            return callId;
        case .answer(let from):
            if (!userSet.contains(from)) {
                let call = self.callsByUser[from]?.last;
                
                self.callArray = self.callArray.map({ c in
                    var tempCall = c;
                    if (tempCall.id == call?.id) {
                        tempCall.status = .ended(reason: .error);
                    }
                    return tempCall;
                })
                
                return nil;
            }
            
            if var currentCall = self.currentCall(user: from) {
                let index = self.callArray.firstIndex { call in
                    call.id == currentCall.id;
                }
                
                if let foundedIndex = index {
                    currentCall.status = .talk;
                    self.callArray[foundedIndex] = currentCall;
                }
                
                return currentCall.id;
            }
            
            return nil;
        case .end(let from):
            if var currentCall = self.currentCall(user: from) {
                let index = self.callArray.firstIndex { call in
                    call.id == currentCall.id;
                }
                
                if let foundexIndex = index {
                    let reason: CallEndReason = currentCall.status == .calling
                        ? .cancel
                        : .end;
                    
                    currentCall.status = .ended(reason: reason);
                    self.callArray[foundexIndex] = currentCall;
                }
                
                self.callArray = self.callArray.map({ call in
                    var tempCall = call;
                    if (tempCall.id == currentCall.id) {
                        tempCall.incomingUser = nil;
                        tempCall.outgoingUser = nil;
                    }
                    return tempCall;
                });
                
                return currentCall.id;
            }
            
            return nil;
        }
    }
    
    func calls() -> [Call] {
        return self.callArray;
    }
    
    func calls(user: User) -> [Call] {
        self.callsByUser[user] ?? [];
    }
    
    func call(id: CallID) -> Call? {
        self.callArray.first { call in
            call.id == id;
        }
    }
    
    func currentCall(user: User) -> Call? {
        if (!userSet.contains(user)) {
            return nil;
        }
        
        return self.callArray.first { call in
            call.status != .ended(reason: .error) && call.incomingUser == user || call.outgoingUser == user;
        }
    }
}
