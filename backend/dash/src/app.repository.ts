import { Injectable } from '@nestjs/common';
import { FirebaseService } from 'src/firebase/firebase.service';

@Injectable()
export class AppRepository<T> {
  constructor(
    private firebaseService: FirebaseService,
    private collection: string,
  ) {
    this.collection = collection + 's';
  }

  async create(dto: T): Promise<string> {
    const postRef = await this.firebaseService
      .getFirestore()
      .collection(this.collection)
      .add(dto);
    return postRef.id;
  }

  async findAll(): Promise<T[]> {
    const snapshot = await this.firebaseService
      .getFirestore()
      .collection(this.collection)
      .get();
    return snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }) as T);
  }

  async findOne(id: string): Promise<T | null> {
    const doc = await this.firebaseService
      .getFirestore()
      .collection(this.collection)
      .doc(id)
      .get();
    return doc.exists ? ({ id: doc.id, ...doc.data() } as T) : null;
  }

  async update(id: string, post: Partial<T>): Promise<void> {
    await this.firebaseService
      .getFirestore()
      .collection(this.collection)
      .doc(id)
      .update(post);
  }

  async remove(id: string): Promise<void> {
    await this.firebaseService
      .getFirestore()
      .collection(this.collection)
      .doc(id)
      .delete();
  }
}
