//
//  CoreDataStack.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/25/25.
//

import Foundation
import CoreData

class CoreDataStack {
	static let shared = CoreDataStack()
	
	let container: NSPersistentContainer
	
	var context: NSManagedObjectContext {
		return container.viewContext
	}
	
	init() {
		container = NSPersistentContainer(name: "USCISCore")
		// to load all data from the container
		container.loadPersistentStores { (description, error) in
			if let error = error {
				print("Error loading core data: \(error)")
			}
		}
	}
	
	
	func loadStoredCases() -> [CaseEntry] {
		let request: NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
		
		do {
			let fetchedCases = try context.fetch(request)
			return fetchedCases.compactMap {$0.toCaseEntry()}
		} catch {
			print("Error on fetching data from core: \(error.localizedDescription)")
			return []
		}
	}
	
	
	/// Function to add a new case to the core data
	func save(_ caseEntry: CaseEntry) async {
		let newCase = CaseEntity(context: context)
		newCase.id = caseEntry.id
		newCase.name = caseEntry.name.capitalized
		newCase.receiptNo = caseEntry.receiptNo
		
		await saveContext()
	}
	
	/// Function for updating the data in coreData.
	func update(id: UUID, name: String, receiptNo: String) async {
		let request: NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
		request.predicate = NSPredicate(format:"receiptNo == %@", receiptNo)
		print(name)
		do {
			let instance = try context.fetch(request).first
			print(instance as Any)
			print("Updating \(String(describing: instance!.name))")
			instance?.name = name
			instance?.receiptNo = receiptNo
			
			await saveContext()
			print("Updated")
		}catch {
			print("Error on updating: \(error.localizedDescription)")
		}
	}
	
	/// Function to delete the data from the core data.
	func delete(_ caseEntry: CaseEntry) async {
		let request: NSFetchRequest<CaseEntity> = CaseEntity.fetchRequest()
		request.predicate = NSPredicate(format:"receiptNo == %@", caseEntry.receiptNo)
		
		do {
			let result = try context.fetch(request)
			if let objectToDelete = result.first {
				context.delete(objectToDelete)
			}
			await saveContext()
		} catch {
			print("Error deleting object: \(error)")
		}
	}
	
	
	/// Function that fetches latest data from core data.
	private func fetchLatestData() async {
		do {
			try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
		}catch{
			print("Error while retrieving data: \(error.localizedDescription)")
		}
	}
	
	
	/// Function for saving to the context.
	func saveContext() async {
		do {
			try context.save()
			print("Case Saved")
		} catch {
			print("Error on saving: \(error.localizedDescription)")
		}
	}
}
