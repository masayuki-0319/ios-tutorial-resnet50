import SwiftUI
import CoreML
import Vision

struct ContentView: View {
    @State var classificationLabel = ""
    
    // 画像識別リクエスト
    func createClassificationRequest() -> VNCoreMLRequest {
        do {
            let configuration = MLModelConfiguration()
            
            let model = try VNCoreMLModel(for: Resnet50(configuration: configuration).model)
            
            let request = VNCoreMLRequest(model: model, completionHandler: { request, error in performClassification(request: request)})
            
            return request
        } catch {
            fatalError("model の読み込みに失敗しました")
        }
    }
    
    // 画像分類
    func performClassification(request: VNRequest) -> Void {
        guard let results = request.results else {
            return
        }
        let classification = results as! [VNClassificationObservation]
        
        classificationLabel = classification[0].identifier
    }
    
    // 画像分類
    func classifyImage(image: UIImage) -> Void {
        guard let ciimage = CIImage(image: image) else {
            fatalError("CIImage に変換失敗しました")
        }
        let handler = VNImageRequestHandler(ciImage: ciimage)
        
        let classificationRequest = createClassificationRequest()
        
        do {
            try handler.perform([classificationRequest])
        } catch {
            fatalError("画像分類に失敗しました")
        }
    }
    
    var body: some View {
        VStack {
            Text(classificationLabel)
                .padding()
                .font(.title)
            Image("shiba")
                .resizable()
                .frame(width: 300, height: 200)
            Button(action: {
                classifyImage(image: UIImage(named: "shiba")!)
            }, label: {
                Text("この画像は何だろう？")
                    .padding()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
