import 'package:ddstudy_ui/ui/widgets/tab_post/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatePostWidget extends StatelessWidget {
  const CreatePostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<CreatePostViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Опубликовать пост"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: viewModel.tec,
                  decoration:
                      const InputDecoration(hintText: "Enter post annotation"),
                  onChanged: (value) {
                    viewModel.annotation = value;
                  },
                ),
              ),
            ),
            Flexible(
              flex: 8,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  ...viewModel.postAttaches
                      .map(
                        (e) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 4,
                            ),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: FileImage(e),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  GestureDetector(
                    onTap: viewModel.addPostAttach,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 4,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      child: const Icon(
                        Icons.add_box_outlined,
                        size: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            viewModel.isLoading
                ? const LinearProgressIndicator()
                : const SizedBox.shrink(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.postAttaches.isEmpty &&
                (viewModel.annotation?.isEmpty ?? true)
            ? () {}
            : viewModel.createPost,
        child: const Icon(Icons.upload),
      ),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CreatePostViewModel(context: context),
      child: const CreatePostWidget(),
    );
  }
}
