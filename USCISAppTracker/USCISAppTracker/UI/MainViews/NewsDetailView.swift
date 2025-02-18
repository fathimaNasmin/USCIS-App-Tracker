//
//  NewsDetailView.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/11/25.
//

import SwiftUI

struct NewsDetailView: View {
	@Environment(\.dismiss) var goBack
	
    var body: some View {
		VStack{
			
			// MARK: Header
			
			SubHeaderView(title: "News", iconName: "bookmark", iconAction: nil)
			
//			 MARK: Contents
			
			ScrollView {
				VStack(alignment: .leading) {
					Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
						.titleStyle(18)
						.fontWeight(.bold)
					
					HStack{
						Text("News source")
		
						Spacer()
						
						Text("2 hours ago")
							
					}
					.captionStyle(14)
					.foregroundColor(Color.textGray)
					.padding(.top, 5)
					
					Divider()
					
					Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum odor amet, consectetuer adipiscing elit. Lacus euismod enim eleifend augue hac suscipit taciti. Nam aliquet dictum himenaeos lectus lacinia purus? Malesuada auctor felis parturient euismod consequat morbi rhoncus lectus mauris. Sit a erat efficitur lectus integer auctor eget. Sociosqu finibus porta praesent rhoncus justo.Nisl feugiat pretium penatibus platea elementum convallis inceptos. Pretium gravida vehicula posuere platea nullam, dui per viverra. Mollis accumsan augue hac eu vulputate viverra. Donec vulputate maximus tempor erat ac ligula. Et varius ipsum sociosqu morbi massa lectus suspendisse consequat. Penatibus litora quam; vestibulum nec interdum purus platea suspendisse. Phasellus imperdiet ex convallis egestas tellus aptent natoque. Nostra congue metus mattis fames felis suscipit. Potenti luctus sollicitudin cras luctus elementum commodo quam. Mus curae nisi laoreet porta ex interdum finibus orci.Ridiculus diam finibus tellus auctor massa cras. Pretium euismod rhoncus sollicitudin massa facilisi ad enim egestas. Egestas mi mus aliquet lacus fermentum risus eros est. Ipsum fames neque nibh bibendum nunc duis etiam dolor. Euismod ante magna; amet viverra ultricies cursus. Tristique nulla elit vulputate auctor, convallis eu aliquet. Risus morbi euismod magna egestas interdum et.Quis risus leo hac sapien rhoncus morbi pharetra? Himenaeos luctus curae accumsan ad consectetur interdum, euismod taciti feugiat. Quisque habitant id suscipit egestas sociosqu litora. Vulputate porta tempor posuere senectus ex torquent elit ornare. Parturient est molestie purus sodales conubia semper magnis rutrum. Elit posuere quis a quis viverra hac aliquam. Nostra purus elit aliquam; condimentum porta a ullamcorper.Dignissim laoreet turpis primis lacinia netus. Integer mattis pellentesque suspendisse magna phasellus mus, arcu aliquet. Justo habitant ridiculus primis lacinia sed et ad nascetur. Magnis senectus lectus nibh, porta nunc quisque faucibus proin commodo? Etiam at auctor cubilia pulvinar conubia maximus natoque dapibus. Quis porta senectus per sociosqu fermentum donec, aliquet nulla enim.")
						.padding(.top)
				}
				.padding(.horizontal)
			}
			
			
		}
    }
}

#Preview {
    NewsDetailView()
}
