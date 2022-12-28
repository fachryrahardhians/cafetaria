import 'package:bloc/bloc.dart';
import 'package:chat_repository/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:merchant_repository/merchant_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ChatRepository _chatRepository;

  UserBloc({
    required ChatRepository chatRepository,
  })  : _chatRepository = chatRepository,
        super(const UserState.initial()) {
    on<GetListUser>(_getListuser);
  }

  Future<void> _getListuser(
    GetListUser event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());

    try {
      final items = await _chatRepository.getUser();

      emit(UserState.success(items));
    } catch (error) {
      emit(UserState.failure(error.toString()));
    }
  }
}
