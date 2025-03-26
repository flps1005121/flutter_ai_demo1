import 'package:flutter/material.dart';
import '../models/pet.dart';

// 自訂 PetTile 來顯示同出生地的其他寵物
class PetTile extends StatelessWidget {
  final Pet pet;

  const PetTile({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(pet.imagePath),
        radius: 20,
      ),
      title: Text(
        pet.breed,
        style: const TextStyle(
          fontFamily: 'Pixel',
          color: Color(0xFFFFA726),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetDetailScreen(pet: pet),
          ),
        );
      },
    );
  }
}

class PetDetailScreen extends StatelessWidget {
  final Pet pet;

  const PetDetailScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final allPets = Pet.getSamplePets();
    final sameOriginPets = allPets
        .where((p) =>
            p.category == pet.category &&
            p.origin == pet.origin &&
            p.breed != pet.breed)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          pet.breed,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Pixel',
          ),
        ),
        backgroundColor: const Color(0xFFFFA726),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 237, 218, 191),
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                pet.imagePath,
                height: 300,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFFF8E1),
                          Color(0xFFFFECB3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pet.breed,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFA726),
                              fontFamily: 'Pixel',
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (pet.origin != null) ...[
                            Text(
                              '出生地：${pet.origin}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontFamily: 'Pixel',
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (sameOriginPets.isNotEmpty) ...[
                              Text(
                                pet.category == 'cat'
                                    ? '同出生地的其他貓咪：'
                                    : '同出生地的其他狗狗：',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFA726),
                                  fontFamily: 'Pixel',
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                height: 150, // 限制 ListView 的高度
                                child: ListView.builder(
                                  itemCount: sameOriginPets.length,
                                  itemBuilder: (context, index) {
                                    final otherPet = sameOriginPets[index];
                                    return PetTile(pet: otherPet);
                                  },
                                ),
                              ),
                            ] else
                              Text(
                                pet.category == 'cat'
                                    ? '目前沒有其他同出生地的貓咪'
                                    : '目前沒有其他同出生地的狗狗',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: 'Pixel',
                                ),
                              ),
                            const SizedBox(height: 10),
                          ],
                          SizedBox(
                            height: 200,
                            child: SingleChildScrollView(
                              child: Text(
                                pet.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontFamily: 'Pixel',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
