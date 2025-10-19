# Kullanılan Teknolojiler

- SwiftUI – Uygulama ve widget arayüzü
- SwiftData (iOS 17+) – Görevlerin kalıcı saklanması
- App Groups – Ana uygulama ↔︎ widget arasında veri paylaşımı
- WidgetKit – Widget zaman çizelgesi ve görselleştirme
- App Intents – Widget üstünden tek dokunuşla işlem (Tamamla/Aç)

# Widget Yapısının Kısa Açıklaması

- Entry/Timeline: TasksEntry (date + son 3 görev) → Provider loadTop() ile SwiftData’dan okur.
- Timeline Policy: policy: .never – Yenile tetiklenir.
- Görünüm: TasksWidgetEntryView başlık + görev satırları; her satırda durum ikonu, başlık ve “Tamamla/Aç” butonu.

# Etkileşimli Özellik Nasıl Çalışır?

- Kullanıcı Widget’taki Tamamla/Aç butonuna basar.
- ToggleTaskIntent çalışır, App Group üzerinden SwiftData kaydını bulur → isDone.toggle() → save.
- Intent sonunda WidgetCenter.shared.reloadTimelines(ofKind: "TasksWidget") çağrılır.
- Provider.getTimeline(...) yeniden çalışır, güncel veriyle widget anında yenilenir.
