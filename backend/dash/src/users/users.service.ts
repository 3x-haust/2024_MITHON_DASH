import { Inject, Injectable } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { User } from './entities/user.entity';
import { ResponseStrategy } from '../shared/strategies/response.strategy';
import { AppRepository } from 'src/app.repository';

@Injectable()
export class UserService {
  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: AppRepository<User>,
    private responseStrategy: ResponseStrategy,
  ) {}

  async create(createUserDto: CreateUserDto) {
    try {
      const user: User = {
        ...createUserDto,
        createdAt: new Date(),
        distance: 0,
        items: '',
        money: 0,
      };
      const id = await this.userRepository.create(user);
      return this.responseStrategy.success('User created successfully', {
        id,
        ...user,
      });
    } catch (error) {
      return this.responseStrategy.error('Failed to create user', error);
    }
  }

  async findAll() {
    try {
      const users = await this.userRepository.findAll();
      return users.length === 0
        ? this.responseStrategy.noContent('No users found')
        : this.responseStrategy.success('Users retrieved successfully', users);
    } catch (error) {
      return this.responseStrategy.error('Failed to retrieve users', error);
    }
  }

  async findOne(id: string) {
    try {
      const user = await this.userRepository.findOne(id);
      return user
        ? this.responseStrategy.success('User retrieved successfully', user)
        : this.responseStrategy.notFound('User not found');
    } catch (error) {
      return this.responseStrategy.error('Failed to retrieve user', error);
    }
  }

  async update(id: string, updateUserDto: UpdateUserDto) {
    try {
      const existingUser = await this.userRepository.findOne(id);
      if (!existingUser) {
        return this.responseStrategy.notFound('User not found');
      }
      const updatedUser: Partial<User> = {
        ...updateUserDto,
      };
      await this.userRepository.update(id, updatedUser);
      return this.responseStrategy.success('User updated successfully', {
        id,
        ...existingUser,
        ...updatedUser,
      });
    } catch (error) {
      return this.responseStrategy.error('Failed to update user', error);
    }
  }

  async remove(id: string) {
    try {
      const existingUser = await this.userRepository.findOne(id);
      if (!existingUser) {
        return this.responseStrategy.notFound('User not found');
      }
      await this.userRepository.remove(id);
      return this.responseStrategy.success('User deleted successfully');
    } catch (error) {
      return this.responseStrategy.error('Failed to delete user', error);
    }
  }
}
