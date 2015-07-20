require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validation' do
    let(:valid_name) { 'Pippo' }
    let(:valid_email) { 'some@gmail.com' }

    before :each do
      @obj = described_class.new(name: valid_name, email: valid_email,
                                 password: '!Peppe11', password_confirmation: '!Peppe11')
    end

    def test_validity
      expect(@obj.valid?).to be false
    end

    it 'reports blank names' do
      @obj.name = ''
      test_validity
    end

    it 'reports blank emails' do
      @obj.email = ''
      test_validity
    end

    it 'reports names longer than 100 chars' do
      @obj.name = 'a' * 101
      test_validity
    end

    it 'reports emails longer than 100 chars' do
      @obj.email = ('a' * 91) << '@gmail.com'
      test_validity
    end

    context 'email format' do
      def test_collection(truth_val, collection)
        collection.each do |email|
          @obj.email = email
          expect(@obj.valid?).to be truth_val
        end
      end

      it 'passes valid emails' do
        valid_emails = %w[me@gmail.com WHAT@gmail.what.com 3-what@GMAIL.COM
                          me_me@gmail.com me+me@gmail.com me*me@gmail.com
                          me&me@gmail.com me~me@gmail.com]
        test_collection true, valid_emails
      end

      it 'reports invalid emails' do
        invalid_emails = %w[@gmail.com @what.com what@.COM me@gmail,com
                            megmail.com foo@bar..com foo@bar. foo@bar_baz.com
                            foo@bar+bir.com]
        test_collection false, invalid_emails
      end

      it 'saved in DB as lowercase with callback' do
        upcased_email = 'PEPPE@GMAIL.COM'
        @obj.email = upcased_email
        @obj.save
        expect(@obj.reload.email).to eq(upcased_email.downcase)
      end
    end

    context 'email uniqueness' do
      it 'reports on previously used emails' do
        other_email = @obj.dup
        @obj.save
        expect(other_email.valid?).to be false
      end
    end

    context 'passwords format' do
      def test_collection(truth_val, collection)
        collection.each do |pass|
          @obj.password = @obj.password_confirmation = pass
          expect(@obj.valid?).to be truth_val
        end
      end

      it 'reports passwords shorter than 6 chars' do
        @obj.password = @obj.password_confirmation = '!P9pp'
        test_validity
      end

      it 'reports invalid passwords' do
        invalid_passwords = %w[3peppee! P3eeeeeee 3!pppppppppp 3pppppppppp !AAAAAAAAA ]
        test_collection false, invalid_passwords
      end

      it 'passes valid passwords' do
        valid_passwords = %w[!Peeeeee3 dfdfs3!P PPPPPP!f88]
        test_collection true, valid_passwords
      end
    end
  end
end
