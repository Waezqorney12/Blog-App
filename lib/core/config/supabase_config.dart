import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupabaseConfig {
  static final supabaseURL = dotenv.env['SupabaseURL'];
  static final supabaseKey = dotenv.env['SupabaseKey'];
}
