import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';

import 'link_email_event.dart';
import 'link_email_state.dart';

class LinkEmailBloc extends Bloc<LinkEmailEvent, LinkEmailState> {
  // ignore: unused_field
  final AuthenticationRepository _authenticationRepository;

  LinkEmailBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(LinkEmailInit()) {
    on<DoEmailLink>((event, emit) => _linkEmail(emit, event));
  }

  Future<void> _linkEmail(
      Emitter<LinkEmailState> emit, DoEmailLink event) async {
    emit(LinkEmailLoading());
    try {
      // TODO: @fachryrahardhians
      // final result = await _authenticationRepository.addLinkedEmail(email: event.email, password: event.password);
      // emit(LinkEmailSuccess(credential: result));
    } catch (e) {
      emit(LinkEmailError(error: e.toString()));
    }
  }
}
