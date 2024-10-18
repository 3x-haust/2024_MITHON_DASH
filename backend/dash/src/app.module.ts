import { Module } from '@nestjs/common';
import { UsersModule } from './users/users.module';
import { CharactersModule } from './characters/characters.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    UsersModule,
    CharactersModule,
  ],
})
export class AppModule {}
