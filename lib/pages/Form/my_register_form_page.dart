import 'package:flutter/material.dart';
import 'package:my_app/base/my_base_stateful_page.dart';

/// 注册表单演示页面
/// 演示 Form 统一校验：姓名、年龄、性别必填，地址、邮编可选；年龄需为数字，性别仅男/女
class MyRegisterFormPage extends MyBaseStatefulPage {
  const MyRegisterFormPage({super.key});

  @override
  State<MyRegisterFormPage> createState() => _MyRegisterFormPageState();

  @override
  String get pageTitle => '注册表单';
}

class _MyRegisterFormPageState extends MyBaseStatefulPageState<MyRegisterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String? _gender; // 男 / 女

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _showGenderPicker(BuildContext context, FormFieldState<String> field) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '选择性别',
                style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 16),
              _buildGenderOption(ctx, '男', field),
              _buildGenderOption(ctx, '女', field),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(
      BuildContext context, String value, FormFieldState<String> field) {
    final isSelected = _gender == value;
    return ListTile(
      title: Text(
        value,
        style: TextStyle(
          fontSize: 18,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: () {
        setState(() => _gender = value);
        field.didChange(value);
        Navigator.pop(context);
      },
    );
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '提交成功：${_nameController.text}，${_ageController.text}岁，$_gender',
          ),
        ),
      );
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '姓名',
                hintText: '请输入姓名',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '姓名不能为空';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: '年龄',
                hintText: '请输入年龄',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return '年龄不能为空';
                }
                final n = int.tryParse(value.trim());
                if (n == null || n < 0 || n > 150) {
                  return '请输入有效的数字年龄（0-150）';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            FormField<String>(
              initialValue: _gender,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请选择性别';
                }
                return null;
              },
              builder: (field) {
                return InputDecorator(
                  decoration: InputDecoration(
                    labelText: '性别',
                    hintText: '请选择性别',
                    border: const OutlineInputBorder(),
                    errorText: field.errorText,
                  ),
                  child: InkWell(
                    onTap: () => _showGenderPicker(context, field),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _gender ?? '请选择性别',
                          style: TextStyle(
                            color: _gender != null
                                ? Theme.of(context).textTheme.bodyLarge?.color
                                : Theme.of(context).hintColor,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: '地址',
                hintText: '选填',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              // 可为空，不写 validator
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _postalCodeController,
              decoration: const InputDecoration(
                labelText: '邮编',
                hintText: '选填',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              // 可为空，不写 validator
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _onSubmit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('确定'),
            ),
          ],
        ),
      ),
    );
  }
}
