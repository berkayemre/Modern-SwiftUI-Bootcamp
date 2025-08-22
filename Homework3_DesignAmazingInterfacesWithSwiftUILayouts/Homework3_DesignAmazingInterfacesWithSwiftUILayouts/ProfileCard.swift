//
//  ContentView.swift
//  Homework3_DesignAmazingInterfacesWithSwiftUILayouts
//
//  Created by Berkay Emre Aslan on 21.08.2025.
//
import SwiftUI

struct ProfileCard: View {
    var body: some View {
            VStack(spacing: 16) {
                ///HEADER
                ZStack {
                    LinearGradient(
                        colors: [.blue, .blue.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    
                    VStack(spacing: 8) {
                        Image("profileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle()
                                .stroke(Color.white.opacity(0.8),
                                        lineWidth: 4))
                            .shadow(radius: 8)
                        
                        Text("Berkay Emre Aslan")
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.white)
                        
                        Text("iOS • SwiftUI • UIKit")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.9))
                        
                    }
                    .padding(.top, 16)
                }
                .padding(.horizontal)
            
                ///BİLGİ KARTI
                HStack(spacing: 12) {
                    InfoCard(title: "Takipçi", value: "120")
                    InfoCard(title: "Takip", value: "150")
                    InfoCard(title: "Beğeni", value: "15K")
                }
                .padding(.horizontal)
                
                ///HAKKIMDA
                Text("Hakkımda")
                    .bold()
                    .font(.title2)
                    .padding(.trailing, 250)
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                      
                        Text(hakkimda)
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .lineSpacing(4)
                    }
                    .padding(.horizontal)
                }
                .background(Color(.gray.opacity(0.1)))

                VStack(spacing: 12) {
                    Button {
                        //
                    } label: {
                        Label("Mesaj Gönder", systemImage: "paperplane.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 12))

                    Button {
                        //
                    } label: {
                        Label("Takip Et", systemImage: "person.fill.badge.plus")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                }
                .padding(.horizontal)
                .padding(.bottom, 24)
            }
    }
    
    let hakkimda = """
    Swift ve SwiftUI ile üretirken amacım; yalın, sürdürülebilir ve test edilebilir arayüzler geliştirmek. Kod yazarken okunabilirliği birinci öncelik kabul ediyorum: anlamlı isimlendirme, tek sorumluluk ilkesi, gereksiz soyutlamalardan kaçınma ve mümkün olduğunca standart kütüphaneleri kullanma. UI tarafında SwiftUI’nin deklaratif yaklaşımı sayesinde state akışını açık seçik kurmayı, side-effect’leri sınırlandırmayı ve hiyerarşiyi basitleştirmeyi hedefliyorum.

    Mimari olarak çoğunlukla MVVM tercih ediyorum: View katmanını “ince”, ViewModel’i ise iş kurallarını ve veri akışını yöneten “kalın” katman olarak tasarlıyorum. Asenkron işlerde Combine ve async/await birlikte kullanımı bana esneklik sağlıyor; ağ isteklerini, yerel önbelleği ve hata yönetimini tek bir akışta toplayıp ViewModel’den View’a sade bir state modeli (enum veya struct) olarak aktarıyorum.

    SwiftUI tarafında @State, @Binding, @StateObject, @ObservedObject ve @EnvironmentObject gibi property wrapper’ları amacına uygun kullanmaya dikkat ediyorum. Karmaşık ekranlarda state’i bölerek küçük, yeniden kullanılabilir View’lara ayırıyorum. Görsel tutarlılık için sistem bileşenlerinden yararlanıp, erişilebilirlik (VoiceOver, Dynamic Type, contrast) kurallarını en baştan sürece dahil ediyorum. Performans için body yeniden hesaplamalarını azaltıyor, idempotent View’lar yazıyor, gerektiğinde @MainActor ve Task cancellation kullanarak akışları güvenli hâle getiriyorum.

    Test kültürü benim için vazgeçilmez: iş kuralı testlerini ViewModel üzerinde birim testlerle, uçtan uca davranışları ise UI testleriyle doğruluyorum. Ağ katmanını protokoller ve bağımlılık enjeksiyonu ile soyutlayıp test doubles/fakes üzerinden sınayıp, snapshot testlerle kritik arayüzlerin görsel regresyonunu kontrol ediyorum.

    Sürümleme ve dağıtım tarafında CI/CD, otomatik test ve lint aşamalarını her commit’te koşacak şekilde kurguluyorum. App Store sürecinde gizlilik, izin metinleri, performans ve çökme raporlarını düzenli takip edip, kullanıcı geri bildirimlerini yol haritasına yansıtıyorum. Ölçeklenebilirlik için modüler proje yapısı, Package Manager kullanımı ve net katman sınırları oluşturuyorum.

    Özetle: Swift ile güvenli ve modern bir dil güvencesi, SwiftUI ile de deklaratif ve hızlı arayüz geliştirme deneyimini birleştirerek; temiz mimari, güçlü test piramidi, erişilebilirlik ve performans temelleri üzerine kurulu, uzun ömürlü uygulamalar üretmeye çalışıyorum. Yazdığım her satırın yarın tekrar okunacağını varsayarak, basitliği ve sürdürülebilirliği öne koyuyorum.
    """

}

struct InfoCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.title3).bold()
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}



#Preview {
    ProfileCard()
}
